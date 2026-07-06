# icoccha 管理画面 — 納品ドキュメント索引（フェーズ8）

| 成果物 | ファイル | 説明 |
|--------|----------|------|
| **管理者マニュアル PDF** | [ADMIN_MANUAL.pdf](./ADMIN_MANUAL.pdf) | 契約必須。再生成: `../scripts/generate-admin-manual-pdf.sh` |
| 管理者マニュアル（詳細版 MD） | [ADMIN_MANUAL.md](./ADMIN_MANUAL.md) | PDF のソース（章立てフル版） |
| 受け入れテスト | [ACCEPTANCE_TEST_CHECKLIST.md](./ACCEPTANCE_TEST_CHECKLIST.md) | 10 項目・手順・合格基準 |
| デモ動画シナリオ | [DEMO_VIDEO_SCRIPT.md](./DEMO_VIDEO_SCRIPT.md) | 顧客確認用録画ガイド（約13分） |
| デプロイ手順 | [../firebase/DEPLOYMENT_GUIDE.md](../firebase/DEPLOYMENT_GUIDE.md) | Firebase デプロイ・フェーズ0〜8 |

## クイックスタート（受け入れテスト）

1. `firebase/DEPLOYMENT_GUIDE.md` に従い Functions をデプロイ
2. `ACCEPTANCE_TEST_CHECKLIST.md` の #1〜#10 を実施
3. 顧客と Pass/Fail を記入・署名
4. `DEMO_VIDEO_SCRIPT.md` でデモ動画を録画して納品
