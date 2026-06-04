# Guia de Setup — do zero ao agente no ar

## O mapa: quem faz o quê

- **GitHub (repositório)** — a casa do agente. Guarda os prompts, o banco de
  ideias, a memória e os agendamentos. Tudo versionado.
- **Claude Code** — onde você constrói e edita o agente conversando (no seu
  computador). É também o motor que roda dentro do GitHub na hora marcada.
- **GitHub Actions** — o despertador. Roda o agente sozinho nos horários
  (segunda 8h = pauta, todo dia 18h = cobrança), sem seu PC ligado.
- **Telegram + ClickUp** — plataformas externas, conectadas por tokens guardados
  como *secrets* no GitHub.

---

## Parte A — Montar a base (uma vez)

### 1. Instalar o Claude Code
- Você precisa de uma conta Claude paga (o **Pro** já serve) ou créditos de API.
- **Jeito recomendado:** o instalador nativo (um comando só, sem precisar de
  Node.js). Pegue o comando no quickstart oficial em `code.claude.com`.
- **Alternativa (via npm, precisa Node 18+):** `npm install -g @anthropic-ai/claude-code`
- **Mac:** use o Terminal.
- **Windows:** instale antes o *Git for Windows* (ele habilita o Bash que os
  scripts usam) e rode no PowerShell.
- Digite `claude` e faça login pelo navegador quando pedir.
- *Prefere algo mais visual?* Existe o app desktop do Claude Code — bom se você
  não vive no terminal.

### 2. Criar o repositório e subir os arquivos
- No GitHub, crie um repositório novo (pode ser **privado**), ex.: `agente-social`.
- Descompacte o `agente-social.zip` e suba os arquivos. Dois caminhos:
  - **Pela web:** "Add file → Upload files" e arraste tudo.
  - **Pelo Claude Code:** abra a pasta no terminal, rode `claude` e peça
    "suba esta pasta para o meu repositório X" — ele executa os comandos git.

### 3. Conectar o Claude Code ao GitHub
- Dentro da pasta do projeto, rode `claude` e use o comando `/install-github-app`.
- Ele guia a instalação do app do GitHub e ajuda a configurar a chave de API.
  É o caminho mais fácil pra deixar os workflows prontos pra rodar.

---

## Parte B — Pegar as chaves e vincular as plataformas

### 4. Chave da Anthropic (paga as execuções do agente)
- Em `console.anthropic.com` → API Keys → crie uma chave. Guarde.

### 5. Telegram
- No app, fale com o **@BotFather** → `/newbot` → siga os passos → guarde o **token**.
- Mande qualquer mensagem pro seu novo bot.
- Abra no navegador: `https://api.telegram.org/bot<SEU_TOKEN>/getUpdates`
  e copie o número em `"chat":{"id": ...}` — esse é o seu **chat_id**.

### 6. ClickUp
- ClickUp → Settings → Apps → **Generate** (API Token pessoal). Guarde.
- Abra a lista onde as peças virarão tarefas. O **list_id** está na URL da lista
  (a sequência de números depois de `/li/`).

### 7. Cadastrar os secrets no GitHub
No repositório → Settings → Secrets and variables → Actions → **New repository secret**.
Crie estes cinco (nome exato à esquerda):
- `ANTHROPIC_API_KEY`
- `TELEGRAM_BOT_TOKEN`
- `TELEGRAM_CHAT_ID`
- `CLICKUP_API_TOKEN`
- `CLICKUP_LIST_ID`

---

## Parte C — Ligar

### 8. Preencher os KPIs
- Complete a seção **Metas / KPIs** no `contexto.md` (pelo Claude Code ou direto na web).

### 9. Testar manualmente
- Aba **Actions** → workflow "Pauta Semanal" → botão **Run workflow**.
- Se a pauta chegar no seu Telegram e as tarefas aparecerem no ClickUp, está no ar.

### 10. Deixar no automático
- Os agendamentos assumem sozinhos: pauta toda segunda 8h, cobrança todo dia 18h.
- Não precisa fazer mais nada. O PC pode estar desligado — roda na nuvem do GitHub.

---

## Como o agente é atualizado (duas vias)

**1. Você muda algo** (tom, um pilar, uma ideia nova):
- Edite o arquivo `.md` — pelo Claude Code ("ajusta o tom pra ser mais X", ele
  edita e dá push) ou direto pela web do GitHub.
- No próximo ciclo, o agente já usa a versão nova. Sem reinstalar nada.

**2. O agente aprende sozinho:**
- Ao rodar, ele escreve em `memoria/aprendizados.md` e `memoria/metricas.md` e
  dá **commit automático**.
- A cada semana ele parte de uma base mais informada. E como tudo fica no
  histórico do git, dá pra ver exatamente o que mudou, quando e por quê.

---

## Como a vinculação funciona por baixo (resumo)

1. Os tokens ficam como **secrets criptografados** no GitHub — nunca no código.
2. Quando um workflow roda, o GitHub injeta os secrets como variáveis de ambiente.
3. Os scripts (`scripts/telegram.sh`, `scripts/clickup.sh`) leem essas variáveis
   e chamam as APIs do Telegram e do ClickUp.
4. Você nunca expõe senha em lugar nenhum — só cadastra os secrets uma vez.
