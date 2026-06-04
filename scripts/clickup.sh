#!/usr/bin/env bash
# Interface simples com a API do ClickUp (REST v2).
# Uso:
#   bash scripts/clickup.sh listar
#   bash scripts/clickup.sh criar "Título da peça" "Roteiro / descrição"
set -euo pipefail
CMD="${1:-}"
BASE="https://api.clickup.com/api/v2"

case "$CMD" in
  listar)
    curl -s -H "Authorization: ${CLICKUP_API_TOKEN}" \
      "${BASE}/list/${CLICKUP_LIST_ID}/task?archived=false&include_closed=false"
    ;;
  criar)
    TITULO="${2:-Nova peça}"
    DESC="${3:-}"
    curl -s -X POST -H "Authorization: ${CLICKUP_API_TOKEN}" \
      -H "Content-Type: application/json" \
      "${BASE}/list/${CLICKUP_LIST_ID}/task" \
      -d "$(jq -n --arg n "$TITULO" --arg d "$DESC" '{name:$n, description:$d}')"
    ;;
  *)
    echo "Comando inválido. Use: listar | criar"
    exit 1
    ;;
esac
