#!/usr/bin/env bash
# Deploy Phase 6 functions (Stripe webhook + mobile APIs).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/firebase/functions"

echo "==> npm install"
npm install

echo "==> TypeScript build"
npm run build

cd "$ROOT/firebase"

if ! npx --yes firebase-tools projects:list >/dev/null 2>&1; then
  echo ""
  echo "Firebase CLI is not authenticated. Run:"
  echo "  npx firebase-tools login"
  echo "  npx firebase-tools use icoccha-admin-dashboard"
  echo ""
  echo "Then set Stripe secrets:"
  echo "  npx firebase-tools functions:config:set stripe.secret_key=\"sk_test_...\" stripe.webhook_secret=\"whsec_...\""
  echo ""
  echo "Deploy:"
  echo "  npx firebase-tools deploy --only functions"
  exit 1
fi

npx --yes firebase-tools use icoccha-admin-dashboard
npx --yes firebase-tools deploy --only functions

echo ""
echo "Register Stripe webhook:"
echo "  https://asia-northeast1-icoccha-admin-dashboard.cloudfunctions.net/stripeWebhook"
