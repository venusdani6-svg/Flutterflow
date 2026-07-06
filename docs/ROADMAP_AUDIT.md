# ロードマップ フェーズ0〜8 — 監査結果

**監査日:** 2026-07-06  
**対象:** `Work_place` リポジトリ全体 vs 段階的ロードマップ

凡例: ✅ 完了 / ⚠️ 一部制限あり / ❌ 未対応（要 FF 再エクスポート or 顧客作業）

---

## フェーズ0 — 基盤整備

| 項目 | 状態 | 備考 |
|------|------|------|
| Firebase プロジェクト固定 | ✅ | `.firebaserc` → `icoccha-admin-dashboard` |
| Functions 統合・デプロイ手順 | ✅ | `firebase/functions/src/` 30+ 関数 |
| 秘密情報ドキュメント | ✅ | `DEPLOYMENT_GUIDE.md` Stripe 節 |
| 管理者 `role_admin` | ✅ | 手動 Firestore 設定 |
| ルーティング修正 | ✅ | `/` → Dashboard（要 auth+admin）、Login ガード |
| 非管理者拒否 | ✅ | `guardAdminAccess` + Login ページ signOut |
| Firestore ルール（モデル A） | ✅ | `users` 自己のみ、他は deny |
| 疎通 `adminHealthCheck` | ✅ | 要デプロイ後確認 |

**修正（今回）:** `DEPLOYMENT_GUIDE` の「フェーズ1で追加予定」記述を削除。

---

## フェーズ1 — データ層

| 項目 | 状態 | 備考 |
|------|------|------|
| `admin_calls.dart` ラッパー | ✅ | 全主要 API |
| FF Firestore スキーマ追加 | ⚠️ | **コード側は `SCHEMA.md` のみ**。FF 再エクスポートで `*_record.dart` 追加が必要 |
| 不足 API（チップ・出金4状態・お知らせ等） | ✅ | 実装済み |
| ココ店 CRUD API | ✅ **今回追加** | `adminGetCocotenShops`, `adminUpsertCocotenShop` |
| 掲示板 API | ✅ **今回追加** | `adminGetJobBoardPosts`, `adminUpsertJobBoardPost` |
| 監査ログ pagination | ✅ **今回修正** | `adminGetAuditLogs` に offset |

---

## フェーズ2 — ダッシュボード

| 項目 | 状態 | 備考 |
|------|------|------|
| KPI 実データ | ✅ | `adminGetDashboardStats` |
| 月次売上グラフ | ✅ | `monthly_sales` |
| ユーザー種別円グラフ | ✅ | guest/cast/staff |
| アクティビティログ | ✅ | 監査ログ直近5件 |
| Primary Scroll 警告 | ⚠️ | レイアウト警告は未一括解消（機能影響小） |

---

## フェーズ3 — 共通 UI キット

| 項目 | 状態 | 備考 |
|------|------|------|
| 検索・ソート・ページネーション | ✅ | `admin_list_*` |
| CSV エクスポート | ✅ | ユーザーリスト系 |
| 確認ダイアログ | ✅ | `admin_confirm_dialog` |
| 詳細共通（監査・凍結・削除） | ✅ | `admin_detail_common_section` |
| 14 ダイアログ → API フィルタ | ⚠️ | 主要リストは API パラメータ直結。**FF ダイアログ comp は一部未配線** |
| 一括操作 | ❌ | 未実装（ロードマップ P2 相当） |

---

## フェーズ4 — コア管理

| 画面 | 状態 |
|------|------|
| ユーザー4種リスト | ✅ body widget 接続 |
| ユーザー詳細 | ✅ API セクション + **静的タブ非表示（今回）** |
| KYC | ✅ |
| 予約リスト・詳細 | ✅ 決済パネル全項目（5/22 合意） |
| 台帳・Stripe ログ | ✅ 3 フィルタ |
| 出金 4 ステータス | ✅ |

**修正（今回）:** 詳細ページの FF 静的プレースホルダー（「ゆずき」等）を `userId`/`reservationId` 指定時に非表示。

---

## フェーズ5 — 設定・コンテンツ

| 項目 | 状態 | 備考 |
|------|------|------|
| システム設定タブ別保存 | ✅ | 5タブ（基本+報酬+アフィリエイト+エリア+タクシー）。ロードマップ「4タブ」は基本4+タクシー拡張と解釈 |
| `features_enabled.cocoten` デフォルト OFF | ✅ | `system_settings_config_bridge` |
| お知らせ CRUD | ✅ | list + edit |
| ガイドライン編集 | ✅ | |
| バナー upsert | ✅ | **Storage アップロードは未実装**（URL 入力） |
| 通報・アフィリエイト | ✅ | body widget 接続 |
| ココ店一覧 | ✅ **今回** | `CocotenListBodyWidget` 接続 |

---

## フェーズ6 — Stripe・モバイル

| 項目 | 状態 | 備考 |
|------|------|------|
| stripe-webhooks.ts | ✅ | ledger + stripe_logs |
| Stripe Connect | ✅ | モバイル callable |
| getAppHomeData / getAppFeatureFlags | ✅ | |
| mobile_calls.dart | ✅ | 別アプリへコピー要 |
| Webhook 本番登録 | ⚠️ | **要 `firebase deploy` + Stripe Dashboard** |

---

## フェーズ7 — 権限・都道府県管理者

| 項目 | 状態 |
|------|------|
| verifyAdmin + requirePermission | ✅ |
| managed_prefectures フィルタ | ✅ |
| メニュー権限連動 | ✅ `AdminSideMenuWidget` |
| 管理者権限編集 UI | ✅ 管理者詳細 |

---

## フェーズ8 — テスト・納品

| 成果物 | 状態 |
|--------|------|
| 受け入れテストチェックリスト | ✅ `docs/ACCEPTANCE_TEST_CHECKLIST.md` |
| 管理者マニュアル PDF | ✅ `docs/ADMIN_MANUAL.pdf` |
| デプロイ手順 | ✅ |
| デモ動画 | ⚠️ シナリオのみ（`docs/DEMO_VIDEO_SCRIPT.md`）顧客録画要 |

---

## 残作業（FlutterFlow / 運用側）

1. **FlutterFlow 再エクスポート** — 追加 Firestore スキーマを FF に登録（`nav.dart` 手編集は上書き注意）
2. **`firebase login` + deploy** — 本番疎通・受け入れテスト実施
3. **モバイルアプリ** — `mobile_calls.dart` 組み込み（KYC・バナー・cocoten）
4. **バナー画像** — Firebase Storage + アップロード UI（任意）
5. **一括操作・dialog comp 全配線** — P2
6. **bundle ID** — ストア公開前に本番 ID へ変更

---

## 今回の修正サマリ

- ココ店・掲示板・監査ログ一覧を API 接続
- ユーザー/予約詳細の静的 FF タブを ID 指定時に非表示
- `adminGetAuditLogs` ページネーション
- `DEPLOYMENT_GUIDE` 古い記述の更新
- `scripts/wire_remaining_lists.py`, `hide_static_detail_placeholders.py` 追加
