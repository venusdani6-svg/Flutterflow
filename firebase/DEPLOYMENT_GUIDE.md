# icoccha 管理画面 — デプロイ手順（フェーズ0）

## Firebase プロジェクト

| 項目 | 値 |
|------|-----|
| プロジェクト ID | `icoccha-admin-dashboard` |
| リージョン（Functions） | `asia-northeast1` |

## 前提条件

- Node.js 20
- Firebase CLI (`npm install -g firebase-tools`)
- `firebase login` 済み

## 0-1. 環境変数・秘密情報（本番前に設定）

```bash
# Stripe（フェーズ6で使用）
firebase functions:config:set \
  stripe.secret_key="sk_test_..." \
  stripe.webhook_secret="whsec_..."

# または Firebase Functions 環境変数（v2 推奨）
firebase functions:secrets:set STRIPE_SECRET_KEY
firebase functions:secrets:set STRIPE_WEBHOOK_SECRET
```

## 0-1. 管理者ユーザーの作成

1. Firebase Console → Authentication → ユーザーを追加（メール/パスワード）
2. Firestore → `users/{uid}` ドキュメントを作成または更新:

```json
{
  "email": "admin@example.com",
  "uid": "<Firebase Auth UID>",
  "role_admin": "admin",
  "created_time": "<Timestamp>"
}
```

`role_admin` が `"admin"` でないユーザーは管理画面に入れません。

## 0-1. バンドル ID（ストア公開時）

現状: `com.mycompany.icocchamockup2`  
本番公開前に Android `applicationId` / iOS `PRODUCT_BUNDLE_IDENTIFIER` を本番用 ID に変更してください。

## ビルドとデプロイ

```bash
cd firebase/functions
npm install
npm run build

cd ..
firebase use icoccha-admin-dashboard
firebase deploy --only functions,firestore:rules
```

## 0-4. 疎通確認

### adminHealthCheck / adminGetDashboardStats

Firebase Console → Functions、または:

```bash
# エミュレータ
cd firebase/functions && npm run build
cd .. && firebase emulators:start --only functions,firestore
```

クライアントからは `lib/backend/cloud_functions/admin_calls.dart` のラッパー関数を呼び出します（例: `adminGetDashboardStats()`）。

### 合格基準

| 確認項目 | 合格基準 |
|----------|----------|
| `adminGetDashboardStats` | 管理者トークンで JSON が返る |
| 管理者ログイン | `role_admin: admin` のみ Dashboard に入れる |
| 非管理者 | ログイン拒否 → signOut |

## アーキテクチャ（フェーズ0-3）

- **クライアント**: 自分の `users/{uid}` のみ Firestore 直読み可
- **管理データ**: Cloud Functions（`verifyAdmin`）経由のみ
- 引き渡しバックエンド（`admin.ts` 全 API）はフェーズ1で本リポジトリに追加予定

## 引き渡しバックエンドの統合

`/Downloads/FlutterFlow/firebase/` に引き渡しコードがある場合:

```bash
# functions/src をマージ後
cd firebase/functions && npm run build
firebase deploy --only functions
```

現リポジトリには `src/admin.ts`（`adminGetDashboardStats`, `adminHealthCheck`）と `src/auth/verifyAdmin.ts` を同梱しています。

---

## フェーズ6 — Stripe・モバイルアプリ連携

### 6-1. デプロイ対象 Functions

| 関数 | 種別 | 用途 |
|------|------|------|
| `stripeWebhook` | HTTP | Stripe Dashboard からの Webhook |
| `createStripeConnectOnboardingLink` | Callable | キャスト Connect onboarding（モバイル） |
| `getStripeConnectStatus` | Callable | Connect 状態確認（モバイル） |
| `getAppHomeData` | Callable | Home バナー・お知らせ・機能フラグ |
| `getAppFeatureFlags` | Callable | タブ表示切替用 `features_enabled` |

```bash
cd firebase/functions && npm run build
cd .. && firebase deploy --only functions
```

### 6-2. Stripe Webhook 登録

1. [Stripe Dashboard](https://dashboard.stripe.com/webhooks) → エンドポイントを追加
2. URL:

```
https://asia-northeast1-icoccha-admin-dashboard.cloudfunctions.net/stripeWebhook
```

3. イベント（最低限）:
   - `payment_intent.succeeded`
   - `charge.refunded`
   - `account.updated`（Connect onboarding 完了同期）

4. 署名シークレットを `STRIPE_WEBHOOK_SECRET`（または `stripe.webhook_secret`）に設定

### 6-3. Webhook → 台帳

`payment_intent.succeeded` → `ledger`（`type: payment`）+ `stripe_logs`  
`charge.refunded` → `ledger`（`type: refund`）  
`account.updated` → `users` の Connect フィールド更新

予約メタデータ: PaymentIntent に `metadata.reservation_id` / `metadata.user_id` を付与すると予約・台帳が紐付きます。

### 6-4. モバイルアプリ側（別リポジトリ）

以下をモバイルプロジェクトにコピー:

- `lib/backend/cloud_functions/mobile_calls.dart`
- `lib/backend/mobile/mobile_app_service.dart`

```dart
import '/backend/cloud_functions/mobile_calls.dart';

// キャスト: Connect onboarding
final link = await createStripeConnectOnboardingLink(
  returnUrl: 'myapp://stripe/return',
  refreshUrl: 'myapp://stripe/refresh',
);

// Home 起動時・プルリフレッシュ
final home = await getAppHomeData();

// 設定保存後のタブ切替確認
final flags = await getAppFeatureFlags();
// flags['featuresEnabled']['cocoten'] 等
```

### 6-5. 機能フラグ・バナー確認手順

1. 管理画面 → システム設定 → `features_enabled` を変更して保存
2. **システム設定管理** → **モバイル連携プレビュー** で `getAppFeatureFlags` / `getAppHomeData` の結果を確認
3. モバイルアプリで同 API を再取得 → タブ表示・Home バナーが切り替わること
4. 管理画面 → バナー一覧で画像 URL・有効フラグを変更 → プレビュー画面で再取得して反映を確認

### 6-6. 疎通確認（エミュレータ）

```bash
cd firebase && firebase emulators:start --only functions,firestore
```

Stripe CLI で Webhook を転送:

```bash
stripe listen --forward-to http://127.0.0.1:5001/icoccha-admin-dashboard/asia-northeast1/stripeWebhook
```

---

## フェーズ7 — 権限・都道府県管理者

### 7-1. 管理者フィールド（`users` ドキュメント）

| フィールド | 値 | 説明 |
|------------|-----|------|
| `admin_role` | `super_admin` | 全画面・全データ |
| `admin_role` | `prefecture_admin` | `admin_permissions` + `managed_prefectures` で制限 |
| `admin_permissions` | map | 画面単位 ON/OFF |
| `managed_prefectures` | array | 例: `["東京都", "神奈川県"]` |

### 7-2. 権限設定 UI

スーパー管理者 → **管理者詳細** → **管理者権限設定** カード  
API: `adminUpdateAdminAccess`（super_admin のみ）

### 7-3. 動作確認

1. 都道府県管理者を作成（`admin_role: prefecture_admin`, 管轄都道府県・画面権限を設定）
2. ログイン → サイドメニューに許可画面のみ表示
3. ユーザー・予約一覧が管轄都道府県のデータのみ返ること（`prefecture` フィールド必須）
4. 未許可 API を直接呼ぶと `permission-denied` になること

---

## フェーズ8 — テスト・納品

### 8-1. 納品物一覧（契約 MS2/MS3）

| 成果物 | パス | 状態 |
|--------|------|------|
| 動作する管理画面 | 本リポジトリ `lib/` + `firebase/functions/` | 実装済み（要デプロイ） |
| 管理者マニュアル PDF | `docs/ADMIN_MANUAL.pdf` | `scripts/generate-admin-manual-pdf.sh` で生成 |
| 管理者マニュアル（ソース） | `docs/ADMIN_MANUAL.md` | 同梱 |
| デプロイ手順 | `firebase/DEPLOYMENT_GUIDE.md` | 本書 |
| 受け入れテストチェックリスト | `docs/ACCEPTANCE_TEST_CHECKLIST.md` | 10 項目穴埋め済み |
| デモ動画シナリオ | `docs/DEMO_VIDEO_SCRIPT.md` | 顧客側録画用 |

### 8-2. 受け入れテスト（10 項目）

`docs/ACCEPTANCE_TEST_CHECKLIST.md` を印刷または共有し、Pass/Fail を記入してください。

| # | テスト | 主要 API / 画面 |
|---|--------|-----------------|
| 1 | 非管理者ログイン拒否 | `admin_login_page`, `guardAdminAccess` |
| 2 | ダッシュボード実データ | `adminGetDashboardStats` |
| 3 | KYC 承認 → アプリ解放 | `adminApproveKYC` → `users.kyc_status` |
| 4 | Stripe ログ 3 フィルタ | `adminGetStripeLogs`, `StripeLogsListBodyWidget` |
| 5 | 予約詳細チップ表示 | `adminGetTipsByReservation`, `ReservationPaymentInfoPanel` |
| 6 | 強制キャンセル | `adminForceCancel` |
| 7 | 出金 4 ステータス | `adminGetPayoutRequests`, `PayoutListBodyWidget` |
| 8 | バナー変更 → アプリ反映 | `adminUpsertBanner`, `getAppHomeData` |
| 9 | 設定タブ個別保存 | `SystemSettingsService.save*` |
| 10 | cocoten OFF 時の挙動 | `features_enabled.cocoten`, `getAppFeatureFlags` |

### 8-3. マニュアル PDF 生成

```bash
chmod +x scripts/generate-admin-manual-pdf.sh
./scripts/generate-admin-manual-pdf.sh
# 出力: docs/ADMIN_MANUAL.pdf
```

pandoc 未インストール時は `docs/ADMIN_MANUAL.md` を Google Docs / Word にインポートして PDF エクスポートも可。

### 8-4. 本番リリース前チェック

```bash
# Functions ビルド
cd firebase/functions && npm run build

# デプロイ（ログイン済み環境）
cd .. && npx firebase-tools deploy --only functions,firestore:rules

# Flutter Web ビルド（ホスティングする場合）
cd ../.. && flutter build web
```

### 8-5. デモ動画

`docs/DEMO_VIDEO_SCRIPT.md` のシナリオ（約 13 分）に沿って録画し、顧客に MP4 を納品してください。
