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

クライアントからは Custom Action `adminGetDashboardStats`（`lib/custom_code/actions/`）を呼び出します。

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
