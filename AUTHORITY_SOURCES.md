# AUTHORITY_SOURCES — ActHub

## Finalidade

Este documento define as fontes de autoridade do ActHub.

Ele existe para impedir que humano, Core Architect ou agentes executores tratem conversa, memória solta, board ou suposição genérica como verdade técnica do projeto.

Quando houver conflito entre fontes, seguir a ordem de autoridade descrita aqui.

---

## Regra central

```text
Código e documentação local versionada vencem memória de chat.
```

O chat pode orientar, mas não é fonte de verdade durável.

---

## Ordem de autoridade

### 1. Código e configuração versionados

Fonte mais concreta para estado técnico real.

Exemplos:

```text
src/backend/
src/frontend/
infra/terraform/
.github/workflows/
package.json
*.csproj
ActHub.sln
*.tf
.gitignore
```

Uso:

- confirmar o que realmente existe;
- validar estrutura física;
- verificar comandos;
- verificar dependências;
- revisar impacto real.

---

### 2. Documentos locais do workspace

Fontes principais de contexto operacional:

```text
WORKSPACE_GUIDE.md
PROJECT_CONTEXT.md
AUTHORITY_SOURCES.md
LOCAL_COMMANDS.md
PROJECT_STATE.md
RISK_SURFACES.md
DONE_CRITERIA.md
OPERATIONAL_REALITY.md
WORKTREE_POLICY.md
GITHUB_PROJECTS_CONTEXT.md
```

Uso:

- orientar agentes;
- classificar risco;
- decidir validação;
- preservar continuidade;
- definir critérios de pronto.

---

### 3. Arquitetura e decisões

Fontes de arquitetura:

```text
ARCHITECTURE.md
docs/adrs/
```

Uso:

- validar decisões estruturais;
- impedir horizontalização indevida;
- avaliar boundaries;
- justificar ou rejeitar mudanças arquiteturais.

Observação:

`ARCHITECTURE.md` é fonte arquitetural principal, mas ADRs vencem quando forem mais específicos e mais recentes.

---

### 4. Estado técnico durável

Fonte:

```text
PROJECT_STATE.md
```

Uso:

- registrar estado técnico atual;
- decisões ativas;
- riscos conhecidos;
- dívidas conscientes;
- limitações;
- follow-ups estruturais.

Não usar para:

- changelog;
- backlog;
- status de board;
- histórico de sessão;
- lista de commits.

---

### 5. Realidade operacional

Fonte:

```text
OPERATIONAL_REALITY.md
infra/terraform/
.github/workflows/
```

Uso:

- entender ambientes;
- runtime;
- cloud;
- CI/CD;
- Terraform;
- limites operacionais;
- segredos sem valores reais;
- lacunas de deploy/observabilidade.

---

### 6. GitHub Issues e GitHub Projects

Fontes de coordenação:

```text
Issues
PRs
GitHub Projects
GITHUB_PROJECTS_CONTEXT.md
```

Uso:

- prioridade;
- sequência de trabalho;
- critérios de aceite;
- status de card;
- discussão de escopo.

Limite:

```text
Board não é verdade técnica.
Issue não prova implementação.
Done não prova validação.
```

---

### 7. Documentos de produto

Fontes de estratégia de produto e GTM:

```text
docs/product/GTM_STRATEGY.md
docs/product/PROJECT_ROADMAP.md
```

Uso:

- entender posicionamento;
- prioridades de produto;
- GTM;
- pricing;
- proposta de valor;
- roadmap macro.

Limite:

Documentos de produto não devem sobrepor arquitetura, segurança ou realidade técnica.

---

### 8. Documentos legados

Fontes históricas:

```text
docs/legacy/PSD.legacy.md
docs/legacy/Memory-Card.legacy.md
PSD.md
docs/governance/Memory-Card.md
```

Uso:

- migração;
- recuperação histórica;
- comparação;
- auditoria de decisões antigas.

Limite:

```text
Não usar documentos legados como fonte operacional principal.
```

Se houver divergência entre legado e documentos novos do harness, prevalecem os documentos novos.

---

## Fontes específicas conhecidas

### Arquitetura

```text
ARCHITECTURE.md
docs/adrs/0001-monolito-modular.md
docs/adrs/0002-vertical-slice-architecture.md
docs/adrs/0003-mensageria-em-memoria-mediatr.md
docs/adrs/0004-infraestrutura-nuvem-azure-terraform.md
```

### Backend

```text
src/backend/ActHub.sln
src/backend/ActHub.Api/
src/backend/ActHub.Modules.Identity/
src/backend/ActHub.Modules.CRM/
src/backend/ActHub.Modules.TrainingPlanning/
src/backend/ActHub.Modules.Execution/
```

### Frontend

```text
src/frontend/
src/frontend/package.json
src/frontend/vite.config.*
src/frontend/manifest.webmanifest
```

### Infraestrutura

```text
infra/terraform/main.tf
infra/terraform/variables.tf
infra/terraform/outputs.tf
infra/terraform/providers.tf
```

### CI/CD

```text
.github/workflows/backend-build.yml
```

### Agentes

```text
AGENTS.md
.opencode/
.agents/
```

Observação:

`AGENTS.md` ainda deve ser migrado para o novo modelo do harness. Enquanto isso não ocorrer, suas regras antigas devem ser lidas com cautela, especialmente a exigência de sobrescrever `PSD.md`.

---

## Como resolver conflitos

### Código vs documentação

Se código e documentação divergirem:

```text
código/config atual vence como realidade
documentação deve ser atualizada
```

Mas se a divergência envolver decisão arquitetural, gerar review ou escalation antes de alterar.

---

### ADR vs ARCHITECTURE

Se ADR específico e `ARCHITECTURE.md` divergirem:

```text
ADR mais específico e vigente vence
ARCHITECTURE.md deve ser ajustado
```

---

### PROJECT_STATE vs board

Se `PROJECT_STATE.md` e board divergirem:

```text
PROJECT_STATE.md vence para verdade técnica
board vence apenas para coordenação
```

---

### Documento novo vs legado

Se documento novo e legado divergirem:

```text
documento novo vence
legado serve apenas como histórico
```

---

### Chat vs repo

Se chat e repo divergirem:

```text
repo vence
```

Chat só vira verdade quando consolidado em documento versionado, ADR, issue ou commit.

---

## Regras para agentes

Antes de qualquer execução relevante, o agente deve consultar:

```text
WORKSPACE_GUIDE.md
PROJECT_CONTEXT.md
AUTHORITY_SOURCES.md
LOCAL_COMMANDS.md
PROJECT_STATE.md
RISK_SURFACES.md
DONE_CRITERIA.md
```

Para tarefas de operação, cloud ou CI/CD, também consultar:

```text
OPERATIONAL_REALITY.md
WORKTREE_POLICY.md
.github/workflows/
infra/terraform/
```

Para tarefas arquiteturais, também consultar:

```text
ARCHITECTURE.md
docs/adrs/
```

Para tarefas de produto, também consultar:

```text
docs/product/GTM_STRATEGY.md
docs/product/PROJECT_ROADMAP.md
```

---

## Regra anti-alucinação

Se uma informação não estiver em fonte confiável, o agente deve dizer:

```text
Não encontrei evidência local suficiente para afirmar isso.
```

Depois deve propor:

```text
onde verificar
qual arquivo consultar
qual comando rodar
qual artifact gerar
```

---

## Comandos para discovery seguro

Comandos seguros para leitura inicial:

```bash
pwd
git status
find . -maxdepth 2 -type f | sort
find . -maxdepth 3 -type f | sort
```

Evitar varredura ampla sem hipótese.

---

## Declaração final

Este documento é o mapa de autoridade do ActHub.

Ele deve ser usado para impedir que agentes inventem estado, comandos, arquitetura ou prioridades.