# Firestore Schema — icoccha 管理画面

引き渡し `schema.md` が未同梱のため、ロードマップ・UI 要件に基づくコレクション定義です。  
**既存 typo は変更しない:** `invitions`, `prefile_image`, `paymet_ledger`（フォルダ名）

## クライアントアクセス方針

| コレクション | クライアント直アクセス | 管理操作 |
|--------------|------------------------|----------|
| `users`（自分の doc） | 読み書き可 | Cloud Functions |
| `invitions` | 作成・読取可 | Functions |
| その他すべて | **不可** | Cloud Functions（`verifyAdmin` / モバイル用 `verifyAuth`） |

モバイル向け読取（バナー・機能フラグ等）は `getAppHomeData` / `getAppFeatureFlags`（認証必須）経由。

---

## users

| フィールド | 型 | 備考 |
|------------|-----|------|
| email | string | |
| uid | string | |
| display_name | string | |
| photo_url | string | |
| prefile_image | string | typo 維持 |
| phone_number | string | |
| role | int | 0=guest, 1=cast, 2=staff |
| role_admin | string | `"admin"` で管理画面可 |
| admin_role | string | super_admin / prefecture_admin |
| admin_permissions | map | 画面単位権限（キー一覧は下記） |
| managed_prefectures | array | 都道府県管理者用 |

`admin_permissions` キー: `dashboard`, `user_management`, `reservations`, `payment_ledger`, `withdrawal`, `kyc`, `reports`, `affiliate`, `cocoten`, `job_board`, `banners`, `system_settings`, `audit_logs`

| is_active | bool | |
| is_frozen | bool | |
| kyc_status | string | pending / approved / rejected |
| affiliate_rate | number | |
| base_hourly_rate | int | |
| prefecture | string | 所属都道府県（都道府県管理者フィルタ用） |
| stripe_connect_account_id | string | Stripe Connect Express（フェーズ6） |
| stripe_connect_onboarding_complete | bool | |
| stripe_connect_charges_enabled | bool | |
| stripe_connect_payouts_enabled | bool | |
| created_time | timestamp | |

## invitions

| フィールド | 型 |
|------------|-----|
| email | string |
| token | string |
| is_used | bool |
| expires_at | timestamp |
| role_admin | string |

## reservations

| フィールド | 型 | 備考 |
|------------|-----|------|
| guest_id | string | |
| cast_id | string | |
| staff_id | string | |
| status | string | |
| scheduled_at | timestamp | |
| base_fee | number | 基本料金 |
| taxi_fee | number | |
| staff_fee | number | |
| tip_total | number | 集計用（ledger とも連携） |
| total_amount | number | 決済総額 |
| extension_count | int | 延長回数 |
| total_duration_minutes | int | |
| thirty_min_rule_applied | bool | |
| sales_finalized_at | timestamp | |
| created_at | timestamp | |
| prefecture | string | 都道府県フィルタ（フェーズ7） |

## ledger

| フィールド | 型 |
|------------|-----|
| type | string | tip, payment, refund, ... |
| amount | number |
| reservation_id | string |
| user_id | string |
| created_at | timestamp |
| description | string |

## stripe_logs

| フィールド | 型 |
|------------|-----|
| event_type | string |
| reservation_id | string |
| stripe_event_id | string |
| created_at | timestamp |
| payload | map |

## payout_requests

| フィールド | 型 |
|------------|-----|
| user_id | string |
| amount | number |
| status | string | pending / approved / on_hold / rejected |
| created_at | timestamp |
| reviewed_at | timestamp |
| reviewed_by | string |

## banners

| フィールド | 型 |
|------------|-----|
| title | string |
| image_url | string |
| link_url | string |
| active | bool |
| sort_order | int |
| updated_at | timestamp |

## system_config（doc: `default`）

| フィールド | 型 |
|------------|-----|
| settings | map | 基本設定 |
| rewards | map | 報酬設定 |
| affiliate | map | アフィリエイト設定 |
| service_areas | array | 提供エリア |
| features_enabled | map | cocoten, staff 等 |

## audit_logs

| フィールド | 型 |
|------------|-----|
| action | string |
| actor_uid | string |
| target_type | string |
| target_id | string |
| changes | map |
| created_at | timestamp |

## reports

| フィールド | 型 |
|------------|-----|
| reporter_id | string |
| reported_user_id | string |
| reason | string |
| status | string |
| created_at | timestamp |

## affiliate_stats / cocoten_shops / chat_rooms

フェーズ5以降で拡張。Functions: `adminGetAffiliateOverview` 等。

## monthly_sales

ダッシュボード棒グラフ用。`month` (string), `amount` (number)。

---

## FlutterFlow 登録手順（1-1）

1. FlutterFlow → Firestore → 上記コレクションを追加
2. フィールド名は **スネークケースのまま** 登録
3. 再エクスポートで `lib/backend/schema/*_record.dart` が生成される
4. 本リポジトリでは `users` / `invitions` のみエクスポート済み — FF 再同期後に残りが追加される

## Custom Actions（1-2）

Dart ラッパー: `lib/backend/cloud_functions/admin_calls.dart`  
FlutterFlow Custom Action として各関数を登録し、戻り値を `dynamic` / JSON として Page State にバインドする。
