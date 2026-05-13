# DONE_CRITERIA — ActHub

## Finalidade

Este documento define o que significa “pronto” no ActHub.

Ele deve ser usado por humano, Core Architect e agentes para evitar encerramento prematuro de tasks sem evidência.

---

## Regra central

```text
Não existe pronto sem evidência.
```

“Funcionou”, “parece ok” e “implementei com sucesso” não são evidência suficiente.

---

## Critérios mínimos para qualquer task

Toda task deve terminar com:

- objetivo atendido ou lacuna declarada;
- escopo respeitado;
- diff revisável;
- validação proporcional;
- riscos remanescentes declarados;
- decisão clara sobre `PROJECT_STATE.md`;
- próximo passo, se houver.

---

## Critérios por classe de risco

## R0 — Investigação sem mutação

Uma task R0 está pronta quando existe:

- pergunta respondida;
- fontes consultadas;
- fatos separados de hipóteses;
- lacunas declaradas;
- recomendação ou próximo passo;
- nenhuma mutação feita.

Artifact recomendado:

```text
Investigation Note
```

---

## R1 — Mudança local pequena e reversível

Uma task R1 está pronta quando existe:

- escopo pequeno e respeitado;
- alteração local revisável;
- `git diff --check` sem problemas;
- validação simples executada ou lacuna declarada;
- Completion Packet enxuto;
- sem risco novo relevante.

Artifacts possíveis:

```text
Execution Plan simples
Completion Packet enxuto
```

---

## R2 — Mudança funcional relevante

Uma task R2 está pronta quando existe:

- Implementation Packet ou demanda consolidada;
- Execution Plan;
- implementação aderente ao plano;
- validação local executada;
- Completion Packet;
- review recomendado ou realizado;
- decisão sobre docs/state;
- riscos residuais explícitos.

Artifacts esperados:

```text
Execution Plan
Completion Packet
Review Report recomendado
```

---

## R3 — Mudança estrutural, sensível ou sistêmica

Uma task R3 só está pronta quando existe:

- plano forte;
- análise de trade-offs;
- validação robusta;
- review obrigatório;
- segurança e operação consideradas;
- ADR/ADR Lite se decisão durável;
- Project State Entry se houver estado técnico novo;
- aprovação humana quando necessário.

Artifacts esperados:

```text
Execution Plan forte
Review Report
ADR/ADR Lite, se aplicável
Project State Entry, se aplicável
```

---

## R4 — Produção, segredo, irreversibilidade ou alto risco

Uma task R4 só pode prosseguir com autorização explícita.

Critérios:

- ação exata autorizada;
- ambiente confirmado;
- risco aceito;
- rollback/mitigação definido;
- evidência registrada;
- review humano;
- nenhum segredo exposto.

Artifacts esperados:

```text
Escalation Note
Plano seguro
Registro de execução
Review humano
```

---

## Critérios por área

## Documentação

Pronto quando:

- o documento tem função clara;
- não duplica fonte existente sem motivo;
- não contradiz authority sources;
- não transforma state em changelog;
- não registra hipótese como fato;
- `git diff --check` passa.

Validação mínima:

```bash
git diff --check
git diff --stat
```

---

## Backend

Pronto quando:

- solution compila;
- escopo respeita módulos;
- não há acoplamento indevido entre bounded contexts;
- não há horizontalização artificial;
- validação foi executada;
- testes existem quando houver lógica relevante;
- riscos de auth/dados foram tratados quando aplicável.

Validação mínima conhecida:

```bash
dotnet restore src/backend/ActHub.sln
dotnet build src/backend/ActHub.sln
git diff --check
```

Quando houver testes:

```text
registrar comando em LOCAL_COMMANDS.md
executar testes relevantes
```

---

## Frontend

Pronto quando:

- build passa;
- alteração é compatível com React/Vite;
- estado e componentes não foram inflados sem necessidade;
- frontend não assume autoridade de segurança;
- dados sensíveis não são armazenados indevidamente;
- UX comunica loading/erro quando aplicável.

Validação mínima conhecida:

```bash
npm --prefix src/frontend run build
git diff --check
```

Se dependências mudarem:

```bash
npm --prefix src/frontend install
npm --prefix src/frontend run build
```

---

## Terraform/IaC

Pronto quando:

- `terraform fmt` aplicado;
- `terraform validate` passa;
- não há secrets no diff;
- não há state/tfvars sensível commitado;
- mudanças com impacto real foram classificadas corretamente;
- `apply` não foi executado sem autorização.

Validação mínima para mudança local:

```bash
cd infra/terraform
terraform fmt
terraform validate
```

Se necessário:

```bash
terraform init
terraform validate
```

Não executar sem autorização explícita:

```bash
terraform apply
terraform destroy
```

---

## CI/CD

Pronto quando:

- workflow é sintaticamente coerente;
- path filters fazem sentido;
- permissões são mínimas;
- secrets não são expostos;
- comandos refletem `LOCAL_COMMANDS.md`;
- escopo do pipeline está claro;
- impacto em branch/PR está entendido.

Para backend build, comandos conhecidos:

```bash
dotnet restore src/backend/ActHub.sln
dotnet build src/backend/ActHub.sln --no-restore
```

---

## Auth/Authz

Pronto apenas com review forte.

Critérios:

- diferença entre autenticação e autorização está clara;
- backend aplica autorização;
- frontend não é fonte de segurança;
- cenários de acesso indevido foram considerados;
- tokens/secrets não são expostos;
- testes cobrem casos negativos;
- review obrigatório.

Risco provável:

```text
R3
```

---

## Banco e dados

Pronto quando:

- schema tem justificativa;
- migration é reversível ou risco é aceito;
- integridade foi considerada;
- query shape foi avaliado;
- dados existentes foram considerados;
- rollback/mitigação existe quando aplicável.

Produção/dado real:

```text
R4
```

---

## Observabilidade

Pronto quando:

- logs ajudam diagnóstico;
- logs não vazam dados sensíveis;
- health checks refletem dependências reais;
- métricas/traces respondem perguntas operacionais;
- não há instrumentação ornamental.

---

## Critérios para Completion Packet

Um Completion Packet aceitável deve conter:

- resumo da mudança;
- arquivos alterados;
- validações executadas;
- validações não executadas;
- riscos remanescentes;
- lacunas;
- decisão sobre `PROJECT_STATE.md`;
- próximo passo.

Não aceitar Completion Packet que diga apenas:

```text
feito
funcionou
testado
tudo certo
```

---

## Critérios para Review Report

Um Review Report aceitável deve conter:

- objeto revisado;
- evidências analisadas;
- aderência ao objetivo;
- escopo;
- validação;
- riscos;
- bloqueios;
- recomendações;
- veredito.

Vereditos permitidos:

```text
aprovado
aprovado com ressalvas
reavaliar
bloquear
```

---

## Quando bloquear uma task

Bloquear se:

- objetivo não foi atendido;
- escopo foi expandido sem autorização;
- validação essencial não foi executada;
- segredo apareceu no diff;
- produção foi tocada sem autorização;
- dependência foi adicionada sem justificativa;
- arquitetura foi alterada sem ADR/review;
- módulo se acoplou indevidamente a outro;
- state foi usado como changelog;
- agente declarou sucesso sem evidência.

---

## Quando aprovar com ressalvas

Aprovar com ressalvas quando:

- objetivo foi atendido;
- risco residual é baixo ou aceito;
- lacunas estão declaradas;
- validação parcial é suficiente para o estágio;
- follow-up está claro;
- não há bloqueio de segurança/produção/dados.

---

## Quando atualizar PROJECT_STATE.md

Atualizar apenas se houver:

- decisão técnica durável;
- risco novo;
- limitação relevante;
- dívida consciente;
- mudança arquitetural;
- mudança operacional;
- integração nova;
- comando relevante;
- follow-up estrutural.

Não atualizar por:

- typo;
- texto de botão;
- commit comum;
- status de board;
- detalhe de diff;
- task pequena sem impacto durável.

---

## Critério de commit

Commit deve ser:

- causal;
- pequeno o suficiente para review;
- alinhado ao escopo;
- sem arquivos sensíveis;
- sem mistura de mudanças não relacionadas.

Antes de commit:

```bash
git status
git diff --stat
git diff --check
```

---

## Declaração final

No ActHub, pronto não significa “o agente terminou de escrever”.

Pronto significa que o resultado é verificável, revisável, proporcional ao risco e honesto sobre suas lacunas.