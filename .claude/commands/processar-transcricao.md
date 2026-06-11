---
description: Garimpa uma transcrição de reunião e gera ideias de conteúdo no formato da marca
argument-hint: [caminho-da-transcricao]
allowed-tools: Read, Edit, Bash
---

# Processar Transcrição → Ideias de Conteúdo

Sua tarefa é transformar uma transcrição de reunião em ideias de conteúdo prontas
para aprovação, seguindo RIGOROSAMENTE o sistema de conteúdo.

## Passo 1 — Carregar o sistema
Leia `content-system.md` na raiz da repo. Ele define o avatar, o
posicionamento, os 4 pilares, o formato de saída, as regras de anonimização e o tom.
Tudo que você gerar tem que obedecer esse arquivo.

## Passo 2 — Ler a transcrição
Leia a transcrição em: $ARGUMENTS
Se for um arquivo `.docx`, extraia o texto primeiro (ex.:
`pandoc "arquivo.docx" -t plain`).

## Passo 3 — Garimpar (não resumir)
Percorra a transcrição procurando MOMENTOS DE CONTEÚDO: uma sacada que ensina, uma
decisão de processo, um erro com lição, uma frase forte, uma tese contrária ao senso
comum. Descarte o trivial e o operacional sem lição. Qualidade acima de quantidade —
prefira 8 ideias fortes a 20 mornas.

## Passo 4 — Gerar no formato
Para cada momento, gere um bloco EXATAMENTE no formato de `content-engine/ideias/exemplos.md`:
- **Pilar:** um dos 4
- **Gancho:** 1 frase de abertura, primeira pessoa, provocativa
- **Tópicos:** 3 a 5 bullets, ordem de fala, linguagem direta
NÃO gere roteiro pronto. Só tópicos pra eu falar natural.

## Passo 5 — Anonimizar (trava de segurança)
Antes de salvar qualquer coisa, revise CADA ideia e remova qualquer nome de cliente,
agência mentorada, pessoa, marca ou dado que identifique terceiro. O protagonista é
sempre eu e o time, nunca o cliente como vilão. Se uma ideia não der pra contar sem
expor alguém, descarte a ideia. Em caso de dúvida, descarte.

## Passo 6 — Salvar e enviar pra aprovação
- Acrescente todas as ideias aprovadas ao final de `content-engine/ideias/backlog.md`.
- Crie uma tarefa no ClickUp para CADA ideia usando o script existente do agente
  (mesmo mecanismo da pauta semanal — NÃO crie implementação paralela):

  bash scripts/clickup.sh criar "<Gancho da ideia>" "Pilar: <X> | Tópicos: <bullets> | Origem: <arquivo da transcrição>"

  O script usa CLICKUP_API_TOKEN e CLICKUP_LIST_ID do ambiente (no GitHub Actions
  vêm dos secrets; rodando local, exporte as mesmas variáveis antes).
- Ao final, envie UM resumo no Telegram usando o script existente:

  bash scripts/telegram.sh "<resumo em Markdown: quantas ideias, distribuição por pilar, transcrição de origem>"

  O script usa TELEGRAM_BOT_TOKEN e TELEGRAM_CHAT_ID do ambiente.

## Passo 7 — Relatório final
Ao terminar, responda com: quantas ideias gerou, a distribuição por pilar, e quantos
momentos você descartou por anonimização. Sem isso, não considere a tarefa concluída.
