#!/usr/bin/env bash
# Envia uma mensagem para o Telegram.
# Uso: bash scripts/telegram.sh "sua mensagem"
set -euo pipefail
MSG="${1:-}"
curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -d chat_id="${TELEGRAM_CHAT_ID}" \
  -d parse_mode="Markdown" \
  --data-urlencode text="${MSG}" > /dev/null
echo "Mensagem enviada ao Telegram."
