# icoccha 管理画面 — 受け入れテストチェックリスト（フェーズ8）

**プロジェクト:** icoccha-admin-dashboard  
**対象:** MS2 / MS3 契約ベース受け入れ  
**実施日:** _______________  
**実施者:** _______________  
**環境:** □ 本番  □ ステージング  □ エミュレータ  

## 前提条件（全テスト共通）

- [ ] `firebase login` 済み、`firebase deploy --only functions,firestore:rules` 完了
- [ ] 管理者ユーザー: `users/{uid}.role_admin == "admin"`
- [ ] 非管理者テスト用ユーザー（`role_admin` なし）を用意
- [ ] 管理画面を Web（Chrome）で起動（デスクトップ幅 1024px 以上推奨）
- [ ] テスト用 Firestore データ（ユーザー・予約・出金・バナー等）を投入済み

---

## テスト一覧

| # | 項目 | 実装 | 結果 | 備考 |
|---|------|------|------|------|
| 1 | 非管理者ログイン拒否 | ✅ | □ Pass □ Fail | |
| 2 | ダッシュボード実データ | ✅ | □ Pass □ Fail | |
| 3 | KYC 承認 → アプリ解放 | ✅ | □ Pass □ Fail | モバイル要確認 |
| 4 | Stripe ログ 3 フィルタ | ✅ | □ Pass □ Fail | |
| 5 | 予約詳細チップ表示 | ✅ | □ Pass □ Fail | |
| 6 | 強制キャンセル | ✅ | □ Pass □ Fail | |
| 7 | 出金 4 ステータス | ✅ | □ Pass □ Fail | |
| 8 | バナー変更 → アプリ反映 | ✅ | □ Pass □ Fail | モバイル要確認 |
| 9 | 設定タブ個別保存 | ✅ | □ Pass □ Fail | |
| 10 | cocoten OFF 時の挙動 | ✅ | □ Pass □ Fail | モバイル要確認 |

---

### #1 非管理者ログイン拒否

**目的:** 管理者以外は管理画面に入れないこと。

**手順:**
1. `/adminLoginPage` を開く
2. `role_admin != "admin"` のユーザーでメール/パスワードログイン
3. ダッシュボードに遷移しないことを確認

**合格基準:**
- [ ] 「管理者権限がありません」ダイアログが表示される
- [ ] 自動的にサインアウトされ、ログイン画面に戻る
- [ ] URL が `/adminDashboardPage` にならない

**実装参照:** `lib/auth/admin_auth_util.dart`, `lib/account/admin_login_page/`

---

### #2 ダッシュボード実データ

**目的:** KPI・グラフが Cloud Functions 経由の実データを表示すること。

**手順:**
1. 管理者でログイン → ダッシュボード
2. Firestore にテストデータ（本日登録ユーザー、予約、台帳 payment 等）を投入
3. 画面をリロードまたは再ログイン

**合格基準:**
- [ ] `adminGetDashboardStats` エラーが表示されない
- [ ] 本日新規登録数・予約数・売上が静的ダミー（固定値）ではなく DB と一致
- [ ] ユーザータイプ円グラフ・月次売上が 0 以外または DB と一致
- [ ] 直近アクティビティログ（監査ログ）が表示される

**API:** `adminGetDashboardStats`  
**実装参照:** `lib/pages/admin_dashboard_page/admin_dashboard_page_model.dart`

---

### #3 KYC 承認 → アプリ解放

**目的:** 管理画面で KYC 承認後、モバイルアプリ側で利用制限が解除されること。

**手順:**
1. テストキャストの `users/{uid}.kyc_status` を `pending` に設定
2. 管理画面 → KYC審査管理 → 対象ユーザーを承認
3. Firestore で `kyc_status == "approved"` を確認
4. モバイルアプリで同一ユーザーとしてログイン（または `users/{uid}` を読み取り）

**合格基準:**
- [ ] 管理画面で承認後、一覧から対象が消える（pending フィルタ）
- [ ] Firestore: `kyc_status: approved`, `kyc_reviewed_at` が設定される
- [ ] モバイル: KYC 未完了ブロックが解除され、通常機能が使える

**API:** `adminApproveKYC`  
**モバイル連携:** アプリは `users/{uid}.kyc_status` を参照（自己ドキュメント読取可）

---

### #4 Stripe ログ 3 フィルタ

**目的:** Stripe ログ一覧で 3 種フィルタが動作すること。

**手順:**
1. 決済・台帳管理 → Stripe ログタブ
2. フィルタ A: イベント種別（例: `payment_intent.succeeded`）→ 検索
3. フィルタ B: 予約 ID を入力 → 検索
4. フィルタ C: 開始日・終了日を指定 → 検索

**合格基準:**
- [ ] 各フィルタ適用後、一覧が絞り込まれる
- [ ] 複合条件でもエラーなく検索できる
- [ ] ページネーションが動作する

**API:** `adminGetStripeLogs`（`eventType`, `reservationId`, `startDate`, `endDate`）  
**実装参照:** `lib/components/admin_common/stripe_logs_list_body_widget.dart`

---

### #5 予約詳細チップ表示

**目的:** 予約詳細画面にチップ合計・有無が表示されること。

**手順:**
1. `ledger` に `type: tip`, `reservation_id: {予約ID}` のエントリを投入
2. 予約管理 → 予約一覧 → 対象予約の詳細を開く
3. 決済情報パネルを確認

**合格基準:**
- [ ] チップ合計金額が表示される
- [ ] チップ有無（あり/なし）が表示される
- [ ] 基本料金・タクシー代・合計等の決済ブロックが表示される

**API:** `adminGetReservation`, `adminGetTipsByReservation`  
**実装参照:** `lib/components/admin_common/reservation_payment_info_panel.dart`

---

### #6 強制キャンセル

**目的:** 管理者が予約を強制キャンセルできること。

**手順:**
1. 予約詳細 → 決済情報パネル内「強制キャンセル」
2. 確認ダイアログで OK
3. Firestore `reservations/{id}.status` を確認

**合格基準:**
- [ ] `status: cancelled`, `cancelled_by: admin` が設定される
- [ ] 監査ログに `reservation_force_cancelled` が記録される
- [ ] UI に成功フィードバックが表示される

**API:** `adminForceCancel`  
**実装参照:** `reservation_payment_info_panel.dart`

---

### #7 出金 4 ステータス

**目的:** 出金申請を 4 ステータスで管理できること。

**手順:**
1. 出金申請管理を開く
2. タブまたはフィルタで以下を確認: `pending` / `approved` / `on_hold` / `rejected`
3. pending の申請に対し「承認」「保留」「否認」アクションを実行

**合格基準:**
- [ ] 4 ステータスすべてで一覧表示できる
- [ ] ステータス変更後、Firestore `payout_requests.status` が更新される
- [ ] 監査ログに `payout_{status}` が記録される

**API:** `adminGetPayoutRequests`, `adminApprovePayout`  
**実装参照:** `lib/components/admin_common/payout_list_body_widget.dart`

---

### #8 バナー変更 → アプリ反映

**目的:** 管理画面のバナー変更がモバイル Home に反映されること。

**手順:**
1. バナー広告管理でバナーを追加/編集（`active: true`, `image_url`, `sort_order`）
2. 管理画面 → システム設定管理 → モバイル連携プレビュー → 再取得
3. モバイルアプリで `getAppHomeData()` を呼び出し（または Home 画面を再表示）

**合格基準:**
- [ ] プレビュー画面に変更後のバナーが表示される
- [ ] モバイル Home に同じバナーが表示される

**API:** `adminUpsertBanner`, `getAppHomeData`  
**実装参照:** `banner_list_body_widget.dart`, `mobile_integration_preview_widget.dart`

---

### #9 設定タブ個別保存

**目的:** システム設定の各タブが個別に保存できること。

**手順:**
1. システム設定管理 → システム設定
2. 各タブで値を変更し、対応する保存ボタンのみ押す:
   - 基本設定を保存する（settings + features_enabled）
   - キャスト報酬設定を保存する
   - アフィリエイト設定を保存する
   - 提供エリア設定を保存する
   - タクシー代設定を保存する
3. Firestore `system_config/default` を確認

**合格基準:**
- [ ] 各保存ボタンで SnackBar 成功メッセージ
- [ ] 該当セクションのみ `system_config` に反映（他セクションは上書きされない）
- [ ] 再読み込み後も値が保持される

**API:** `adminUpdateSystemConfig`, `adminGetSystemConfig`  
**実装参照:** `system_settings_service.dart`

---

### #10 cocoten OFF 時の挙動

**目的:** `features_enabled.cocoten == false` のとき、モバイルでココ店タブが非表示になること。

**手順:**
1. システム設定 → 基本設定タブ → cocoten（ココ店）スイッチを OFF
2. 「基本設定を保存する」
3. モバイル連携プレビューで `getAppFeatureFlags` を確認
4. モバイルアプリでタブ表示を確認

**合格基準:**
- [ ] Firestore: `features_enabled.cocoten == false`
- [ ] プレビュー: `cocoten` フラグが false
- [ ] モバイル: ココ店タブ/メニューが非表示
- [ ] 管理画面のココ店管理メニューは権限により表示（都道府県管理者は `admin_permissions.cocoten` で制御）

**API:** `adminUpdateSystemConfig`, `getAppFeatureFlags`  
**デフォルト:** `features_enabled.cocoten` は false（未設定時）

---

## 既知の制限（納品時点）

| 項目 | 内容 |
|------|------|
| デプロイ | 本番 Functions は `firebase login` + `deploy` が必要 |
| モバイル #3, #8, #10 | 別リポジトリのモバイルアプリに `mobile_calls.dart` 組み込みが必要 |
| バナー画像 | URL テキスト入力のみ（Storage アップロード未実装） |
| デモ動画 | `docs/DEMO_VIDEO_SCRIPT.md` に沿って顧客側で録画 |

---

## 署名

| 役割 | 氏名 | 日付 | 署名 |
|------|------|------|------|
| 開発側 | | | |
| 顧客側 | | | |
