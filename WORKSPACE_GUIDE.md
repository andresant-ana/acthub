# WORKSPACE_GUIDE — ActHub

## Finalidade

Este é o guia de entrada do workspace ActHub.

Ele deve ser lido por humano, Core Architect e agentes antes de planejar, implementar, revisar ou encerrar tarefas relevantes neste repositório.

---

## Regra central

```text
Comece pela verdade local.
```

Não use memória de chat, suposição genérica ou preferência de ferramenta como fonte primária quando houver documentação local, código, configuração, ADR ou estado técnico versionado.

---

## Ordem recomendada de leitura

Para qualquer task relevante, leia primeiro:

```text
PROJECT_CONTEXT.md
AUTHORITY_SOURCES.md
LOCAL_COMMANDS.md
PROJECT_STATE.md
RISK_SURFACES.md
DONE_CRITERIA.md
```

Para operação, infraestrutura, CI/CD ou cloud, leia também:

```text
OPERATIONAL_REALITY.md
WORKTREE_POLICY.md
infra/terraform/
.github/workflows/
```

Para arquitetura, leia também:

```text
ARCHITECTURE.md
docs/adrs/
```

Para produto, GTM ou roadmap, leia também:

```text
docs/product/GTM_STRATEGY.md
docs/product/PROJECT_ROADMAP.md
```

Para board/issues, leia também:

```text
GITHUB_PROJECTS_CONTEXT.md
```

---

## Estrutura principal

```text
src/backend/
  ActHub.sln
  ActHub.Api/
  ActHub.Modules.Identity/
  ActHub.Modules.CRM/
  ActHub.Modules.TrainingPlanning/
  ActHub.Modules.Execution/

src/frontend/
  React PWA

infra/terraform/
  Terraform Azure

docs/adrs/
  decisões arquiteturais

docs/product/
  estratégia de produto e roadmap

docs/legacy/
  documentos antigos preservados apenas para histórico
```

---

## Papel dos documentos locais

### `PROJECT_CONTEXT.md`

Explica o que é o ActHub, qual problema resolve, qual domínio atende, qual stack usa e qual é o estágio atual.

### `AUTHORITY_SOURCES.md`

Define onde está a verdade local e como resolver conflitos entre código, documentação, ADR, board e documentos legados.

### `LOCAL_COMMANDS.md`

Lista comandos reais e conhecidos do projeto. Agentes não devem inventar comandos fora dele sem investigação.

### `PROJECT_STATE.md`

Preserva estado técnico durável. Não é changelog, backlog, board nem diário.

### `RISK_SURFACES.md`

Mapeia riscos de auth, dados, banco, Terraform, Azure, CI/CD, frontend, bounded contexts e secrets.

### `DONE_CRITERIA.md`

Define o que significa pronto para cada tipo de task e classe de risco.

### `OPERATIONAL_REALITY.md`

Registra ambiente local, cloud, CI/CD, deploy, observabilidade, secrets e lacunas operacionais.

### `WORKTREE_POLICY.md`

Define Git, branch, commit, worktree e operações sensíveis.

### `GITHUB_PROJECTS_CONTEXT.md`

Define como usar board/issues sem confundir coordenação com verdade técnica.

---

## Arquitetura base

O ActHub usa:

```text
Monólito Modular
Vertical Slice Architecture
Bounded Contexts
PostgreSQL
Azure
Terraform
React PWA
```

A regra arquitetural central é:

```text
complexidade precisa pagar aluguel
```

Evitar:

- microsserviços prematuros;
- Kubernetes sem dor real;
- camadas horizontais genéricas;
- `Controllers`, `Services`, `Repositories`, `Core`, `Application`, `Infrastructure` como default ritualístico;
- abstrações sem segunda ocorrência;
- dependências por conveniência do agente.

---

## Bounded Contexts

```text
Identity & Access
CRM & Engagement
Training Planning
Execution & Analytics
```

Módulos não devem se acoplar diretamente.

Mudanças de boundary, dependência entre módulos, eventos inter-módulos ou shared kernel devem ser tratadas como sensíveis e provavelmente R3.

---

## Classes de risco

```text
R0 — leitura/investigação sem mutação
R1 — mudança local pequena e reversível
R2 — mudança funcional relevante
R3 — mudança estrutural, sensível ou sistêmica
R4 — produção, segredo, irreversibilidade ou alto risco
```

Em caso de dúvida, classifique de forma conservadora.

---

## Fluxo recomendado de task

### 1. Intake

Entender:

- objetivo;
- contexto;
- escopo;
- fora do escopo;
- risco inicial;
- fonte de autoridade;
- validação esperada.

### 2. Plan

Antes de mutação R1+ relevante, produzir ou exigir Execution Plan.

### 3. Implement

Executar somente dentro do plano.

O implementer não deve:

- redesenhar arquitetura;
- expandir escopo;
- criar dependência sem justificativa;
- tocar produção;
- expor segredo;
- alterar Terraform real sem autorização.

### 4. Review

Para R2+ ou superfícies sensíveis, revisar com base em evidência.

Vereditos aceitos:

```text
aprovado
aprovado com ressalvas
reavaliar
bloquear
```

### 5. Handoff

Encerrar com:

- o que foi feito;
- validações executadas;
- validações não executadas;
- lacunas;
- riscos;
- decisão sobre `PROJECT_STATE.md`;
- próximo passo.

---

## Comandos principais

Backend:

```bash
dotnet restore src/backend/ActHub.sln
dotnet build src/backend/ActHub.sln
dotnet sln src/backend/ActHub.sln list
```

Frontend:

```bash
npm --prefix src/frontend install
npm --prefix src/frontend run build
```

Terraform:

```bash
cd infra/terraform
terraform fmt
terraform validate
```

Git/documentação:

```bash
git status
git diff --stat
git diff --check
```

Comandos sensíveis como `terraform apply`, `terraform destroy`, `git reset --hard`, `git clean -fd` e `git push --force` exigem autorização explícita.

---

## Uso de agentes

Agentes devem ser tratados como papéis operacionais:

```text
planner        → planeja, não implementa
researcher     → investiga, não muta
implementer    → executa plano, não redesenha
reviewer       → audita, não corrige diretamente
architect-critic → critica arquitetura e trade-offs
delivery-prep  → prepara fechamento e state decision
mcp-observer   → lê externo em modo read-only
```

Nenhum agente deve tocar produção, segredo ou escrita externa sem autorização explícita.

---

## Uso de PROJECT_STATE

Atualizar `PROJECT_STATE.md` apenas quando houver:

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

- commit comum;
- status de card;
- typo;
- detalhe de diff;
- pequena mudança documental;
- Completion Packet inteiro.

---

## Uso de documentos legados

Documentos legados estão em:

```text
docs/legacy/
```

Eles servem para histórico e migração.

Não devem vencer:

```text
PROJECT_STATE.md
PROJECT_CONTEXT.md
ARCHITECTURE.md
ADRs
código atual
```

---

## Primeira task piloto recomendada

A primeira task com harness/Core Architect/OpenCode deve ser pequena, reversível e validável.

Evitar no primeiro piloto:

- auth;
- autorização;
- Terraform apply;
- Azure real;
- secrets;
- deploy;
- migrations;
- banco real;
- mudança arquitetural estrutural.

Preferir:

- documentação;
- CI sem segredo;
- análise estática;
- validação de build;
- ajuste operacional pequeno.

---

## Declaração final

O ActHub deve ser conduzido como projeto de portfólio sério, mas sem teatro arquitetural.

A maturidade deve aparecer na clareza das decisões, na qualidade da validação e no controle de risco, não na quantidade de camadas ou ferramentas.