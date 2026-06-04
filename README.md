# Agente Social Media — Luiz

Agente autônomo que gera pauta, cobra a execução e aprende com os resultados
para a marca pessoal do Luiz. Roda sozinho no GitHub Actions, conversa pelo
Telegram e usa o ClickUp como fonte de verdade das tarefas.

## Como funciona

```
[GitHub Actions agenda]
        │
        ├─ Segunda 08h  → Pauta Semanal: gera 3-4 peças → cria tarefas no ClickUp → resumo no Telegram
        └─ Todo dia 18h → Cobrança: lê o ClickUp → cobra o que está parado no Telegram
        │
        └─ Ao aprender algo, escreve em memoria/ e dá commit (memória versionada)
```

O **loop de otimização**: a cada execução o agente pode atualizar
`memoria/aprendizados.md` e `memoria/metricas.md`, e esses arquivos são
commitados de volta no repo. Na execução seguinte ele lê a versão atualizada.
É isso que faz o agente melhorar com o tempo — e fica tudo versionado no git.

## Estrutura

| Arquivo | O que é |
|---|---|
| `contexto.md` | Quem é o Luiz: objetivo, público, tom, pilares, formato. A base de tudo. |
| `banco-de-ideias.md` | Ideias de pauta do Luiz, por pilar. O agente puxa daqui antes de inventar. |
| `system-prompt.md` | O cérebro: as 5 funções e como o agente se comporta. |
| `memoria/aprendizados.md` | O que funciona e o que não. O agente atualiza sozinho. |
| `memoria/metricas.md` | Histórico de desempenho das peças. |
| `scripts/telegram.sh` | Envia mensagem pro Telegram. |
| `scripts/clickup.sh` | Lê e cria tarefas no ClickUp. |
| `.github/workflows/` | Os dois agendamentos (pauta e cobrança). |

## Setup (uma vez)

1. **Crie o bot do Telegram**: fale com o [@BotFather](https://t.me/BotFather),
   use `/newbot`, guarde o **token**. Mande uma mensagem pro seu bot e pegue seu
   **chat_id** em `https://api.telegram.org/bot<TOKEN>/getUpdates`.
2. **Pegue o token do ClickUp**: Settings → Apps → API Token (token pessoal).
   Pegue também o **list_id** da lista onde as peças vão virar tarefas (está na URL da lista).
3. **No GitHub**, em Settings → Secrets and variables → Actions, crie:
   - `ANTHROPIC_API_KEY`
   - `TELEGRAM_BOT_TOKEN`
   - `TELEGRAM_CHAT_ID`
   - `CLICKUP_API_TOKEN`
   - `CLICKUP_LIST_ID`
4. **Preencha o que falta** no `contexto.md`: referências de perfis, restrições e metas.
5. **Teste**: na aba Actions, rode "Pauta Semanal" manualmente (botão *Run workflow*).
   Se chegar a pauta no Telegram, está no ar.

> Por que ClickUp via API e não MCP? No GitHub Actions (ambiente headless) o login
> OAuth do MCP não roda. A API com token pessoal é mais robusta pra automação agendada.

## Como o agente entrega a pauta (formato de tópicos, não roteiro)

O Luiz grava de uma vez só, com as próprias palavras. Então cada peça vem assim:

```
PEÇA 1 — Pilar: Erros que custam caro | Formato: Reel
Ideia central: o erro de gastar em anúncio antes de arrumar o perfil.
Gancho: "Parar de jogar dinheiro fora começa por aqui."
Tópicos:
  - o que o empresário vê: anúncio rodando, zero retorno
  - a causa real: perfil/oferta não convertem o clique
  - o que arrumar primeiro (bio, destaque, prova)
  - quando faz sentido investir em tráfego
CTA: "Comenta 'PERFIL' que eu te mando o checklist."
Testando: gancho de "parar de perder dinheiro".
```

Nada de texto pra ler — só o caminho pra ele desenvolver na hora.

## Ajustando o agente

Mudou de ideia sobre tom, pilares ou ritmo? Edite o `contexto.md`.
Quer mudar como ele pensa ou cobra? Edite o `system-prompt.md`.
Tudo versionado: cada ajuste fica no histórico do git.
