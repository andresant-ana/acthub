# PROJECT_STATE — ActHub

## Status

```text
Última atualização: 2026-05-13
Fonte de migração: PSD.md, docs/governance/Memory-Card.md, ARCHITECTURE.md e estado atual do repositório
Maturidade: estado inicial migrado para o modelo do harness
```

---

## Finalidade

Este documento preserva o estado técnico durável do ActHub.

Ele não é changelog, backlog, board, diário de sessão nem lista de commits.

Registrar aqui apenas informações que precisam sobreviver a sessões futuras porque afetam decisões técnicas, execução, risco, arquitetura ou operação.

---

## Identidade técnica atual

O ActHub é um SaaS B2B2C para gestão, periodização e acompanhamento de treinos, com foco em personal trainers e seus alunos.

A arquitetura alvo combina:

```text
Monólito Modular
Vertical Slice Architecture
Bounded Contexts
.NET 8
React PWA
PostgreSQL
Azure
Terraform
GitHub Actions
```

---

## Linha de chegada do MVP

A definição formal do MVP está em:

```text
docs/product/MVP_DEFINITION.md
```

Resumo:

```text
MVP = fluxo privado e funcional para um personal trainer cadastrar alunos, prescrever treinos, permitir execução pelo aluno, registrar histórico e visualizar progressão básica.
```

O MVP não é lançamento público de SaaS, marketplace, app nativo, billing completo, IA, BI avançado ou plataforma enterprise.

---

## Estado atual resumido

```text
Estado: scaffolding estrutural concluído
Domínio funcional: ainda não implementado
Backend: solution .NET criada
Frontend: fundação React PWA criada
Infraestrutura: Terraform inicial existente
CI/CD: pipeline backend build existente
Documentação local do harness: migração principal concluída
AGENTS.md: migrado para o modelo do harness
MVP: definido em docs/product/MVP_DEFINITION.md
Próxima prioridade registrada: fundação de qualidade antes de domínio funcional
```

---

## Topologia física atual

```text
src/backend/
  ActHub.sln
  ActHub.Api/
  ActHub.Modules.Identity/
  ActHub.Modules.CRM/
  ActHub.Modules.TrainingPlanning/
  ActHub.Modules.Execution/

src/frontend/
  fundação React PWA

infra/terraform/
  main.tf
  variables.tf
  outputs.tf
  providers.tf

docs/adrs/
  ADRs arquiteturais iniciais

docs/product/
  GTM_STRATEGY.md
  MVP_DEFINITION.md
  PROJECT_ROADMAP.md

docs/legacy/
  PSD.legacy.md
  Memory-Card.legacy.md

.github/workflows/
  backend-build.yml
```

---

## Documentação operacional atual

Os documentos locais do harness para o ActHub estão criados:

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
docs/product/GTM_STRATEGY.md
docs/product/MVP_DEFINITION.md
docs/product/PROJECT_ROADMAP.md
```

O `AGENTS.md` foi migrado para o modelo do harness e agora orienta agentes a usar os documentos locais, não mais `PSD.md` como fonte operacional principal.

---

## Documentos legados

Os documentos abaixo são legados:

```text
PSD.md
docs/governance/Memory-Card.md
docs/legacy/PSD.legacy.md
docs/legacy/Memory-Card.legacy.md
```

Uso permitido:

```text
histórico
auditoria
recuperação de contexto antigo
comparação durante migração
```

Uso proibido:

```text
fonte operacional principal
estado técnico atual
comando para agentes
substituto de PROJECT_STATE.md
```

A verdade operacional atual deve vir dos documentos locais do harness, do código, dos ADRs e das configurações versionadas.

---

## Decisões arquiteturais ativas

### Monólito Modular

Status:

```text
ativo
```

Decisão:

O ActHub deve iniciar como Monólito Modular, não como microsserviços.

Racional:

- estágio inicial do produto;
- menor custo operacional;
- menor complexidade de deploy;
- menor necessidade de observabilidade distribuída;
- melhor navegabilidade para humano e agentes;
- modularidade lógica ainda preserva evolução futura.

Revisar quando:

- houver escala independente real;
- houver necessidade de deploy independente;
- houver boundary organizacional real;
- o monólito modular gerar dor observável.

---

### Vertical Slice Architecture

Status:

```text
ativo
```

Decisão:

O ActHub deve organizar funcionalidades por fatias verticais, evitando horizontalização genérica por `Controllers`, `Services`, `Repositories`, `Core`, `Application` e `Infrastructure` como default.

Racional:

- nem todo fluxo tem a mesma complexidade;
- reduz cerimônia;
- aproxima código do caso de uso;
- facilita evolução por feature;
- ajuda o agente a trabalhar com escopo local.

Observação:

A proibição é contra horizontalização ritualística. Exceções podem existir se justificadas por dor real e registradas por ADR.

---

### Bounded Contexts

Status:

```text
ativo
```

Contexts atuais:

```text
Identity & Access
CRM & Engagement
Training Planning
Execution & Analytics
```

Regra:

Módulos não devem se acoplar diretamente entre si.

Mudanças que cruzem boundaries devem ser tratadas como sensíveis e provavelmente R3.

---

### Mensageria em memória via MediatR

Status:

```text
decisão arquitetural aceita, ainda não implementada funcionalmente
```

Decisão:

Comunicação inter-módulos planejada por eventos em memória usando MediatR.

Limite:

Não antecipar eventos, handlers ou infraestrutura de mensageria antes de uma fatia funcional justificar.

---

### Azure + Terraform

Status:

```text
ativo
```

Decisão:

Infraestrutura declarada via Terraform para Azure.

Recursos conhecidos do histórico:

- Resource Group;
- App Service Plan Linux;
- PostgreSQL Flexible Server;
- Azure Key Vault;
- região `brazilsouth`.

Risco:

Infraestrutura real e secrets elevam risco. Operações `apply`, `destroy`, alteração de Key Vault, banco ou App Service exigem autorização explícita.

---

## ADRs vigentes conhecidos

```text
0001 — Monólito Modular
0002 — Vertical Slice Architecture
0003 — Mensageria em Memória via MediatR
0004 — Infraestrutura em Nuvem Azure com Terraform
```

Manter `docs/adrs/` como fonte específica de decisões arquiteturais.

---

## Estado do backend

```text
Runtime: .NET 8
Solution: src/backend/ActHub.sln
Host: ActHub.Api
Módulos:
  ActHub.Modules.Identity
  ActHub.Modules.CRM
  ActHub.Modules.TrainingPlanning
  ActHub.Modules.Execution
```

Estado funcional:

```text
sem endpoints de domínio implementados
sem persistência funcional implementada
sem autenticação/autorização funcional implementada
sem MediatR funcional aplicado ao domínio
sem Polly/Serilog/OpenTelemetry/Health Checks funcionais aplicados
sem testes automatizados consolidados
```

---

## Estado do frontend

```text
Stack: React PWA com Vite/TypeScript
Local: src/frontend/
```

Estado funcional:

```text
fundação inicial criada
experiência final ainda não implementada
offline-first ainda não implementado
IndexedDB/service workers ainda não consolidados como feature
build frontend ainda precisa ser consolidado em pipeline
```

---

## Estado da infraestrutura

```text
Local: infra/terraform/
Cloud alvo: Azure
Banco alvo: PostgreSQL Flexible Server
Região registrada: brazilsouth
```

Riscos conhecidos:

- Terraform pode tocar recursos reais;
- estado local Terraform é sensível;
- secrets não devem ser expostos;
- Key Vault não elimina risco de estado local;
- alterações cloud exigem plano e autorização.

---

## Estado de CI/CD

Workflow existente:

```text
.github/workflows/backend-build.yml
```

Função:

```text
build do backend em push/pull_request quando há mudanças em src/backend/**
```

Pendências conhecidas:

```text
pipeline de análise estática
pipeline de frontend
pipeline de deploy
validação Terraform em CI
gates de qualidade mais completos
```

---

## Estado do MVP

Status:

```text
MVP definido, não implementado
```

Funcionalidades ainda necessárias para MVP:

```text
Identity & Access mínimo
CRM básico de alunos
catálogo mínimo de exercícios
prescrição de treino
execução de treino pelo aluno
histórico de execução
progressão básica
interface PWA mínima para personal e aluno
operação mínima para piloto controlado
```

Fora do MVP:

```text
microsserviços
Kubernetes
CQRS global
Event Sourcing
app nativo
marketplace
billing completo
afiliados
IA generativa
BI avançado
churn prediction avançado
offline-first completo
produção pública
```

---

## Riscos técnicos ativos

### Secrets e Terraform State

Status:

```text
ativo
```

Houve exposição operacional prévia de credencial em contexto de conversa, tratada por rotação.

Risco permanente:

- não expor secrets;
- não commitar `.tfstate`;
- não commitar `.tfvars` sensível;
- proteger estado local;
- considerar remote state futuramente.

---

### Autenticação e autorização

Status:

```text
não implementado, risco futuro alto
```

Qualquer task de auth/authz deve ser tratada como sensível.

Classificação provável:

```text
R3
```

ou `R4` se envolver segredo, produção ou dados reais.

---

### Multi-tenancy e isolamento personal-aluno

Status:

```text
não implementado, risco futuro alto
```

O MVP precisa impedir acesso cruzado entre personal trainers, alunos e dados de execução.

Classificação provável:

```text
R3
```

---

### Banco de dados e migrations

Status:

```text
persistência funcional ainda não implementada
```

Risco:

- migrations com dados reais serão sensíveis;
- schema deve ser pensado com rollback e integridade;
- query shape deve ser revisado.

---

### Cálculos de progressão

Status:

```text
não implementado
```

Cálculos como volume e 1RM estimado devem ter fórmula explícita e testes.

Erro nessa área prejudica a confiança central do produto.

---

### Cloud e custo

Status:

```text
risco operacional e financeiro conhecido
```

Há histórico de decisão ligada a região, cota e SKU.

Mudanças de Azure devem considerar:

- custo;
- limites de free trial/créditos;
- região;
- SKU;
- deploy;
- rollback;
- segurança.

---

### Documentação legada

Status:

```text
legado preservado, não operacional
```

`PSD.md` e `docs/governance/Memory-Card.md` foram substituídos operacionalmente por documentos locais do harness.

Decisão atual:

- manter cópias históricas em `docs/legacy/`;
- manter arquivos legados ativos como stubs de depreciação;
- não usar legados como fonte principal para agentes.

---

## Dívidas técnicas/documentais conscientes

### Decidir remoção futura dos stubs legados

Motivo:

`PSD.md` e `docs/governance/Memory-Card.md` ainda existem na árvore para compatibilidade e orientação histórica.

Ação futura:

Depois de alguns ciclos usando o harness, decidir se:

```text
1. os stubs permanecem;
2. os stubs são removidos;
3. os caminhos antigos são mantidos apenas para referência de migração.
```

---

### Revisar ARCHITECTURE.md

Motivo:

`ARCHITECTURE.md` é aproveitável e continua sendo fonte arquitetural principal, mas pode conter linguagem mais absoluta que o necessário.

Ação futura:

Revisar termos como “proibido” quando for melhor registrar como “não permitido por padrão salvo ADR explícita”.

---

### Completar pipelines

Pendências conhecidas:

```text
análise estática
frontend build
deploy
terraform validation
```

---

### Definir testes

Ainda não há estrutura de testes consolidada.

Ação futura:

- criar projetos de teste para backend;
- definir comando local;
- registrar em `LOCAL_COMMANDS.md`;
- integrar em CI.

---

## Próximas ações naturais

1. Commitar `docs/product/MVP_DEFINITION.md` e ajustes de roadmap/state.
2. Subir fontes macro limpas no Project ActHub, se for usar Project.
3. Escolher primeira task piloto pequena.
4. Gerar prompt para OpenCode usando o Core Architect.
5. Rodar piloto com Completion Packet e Review Report.
6. Avaliar se `PROJECT_STATE.md` precisa de atualização após o piloto.

---

## Critério para atualizar este arquivo

Atualizar `PROJECT_STATE.md` apenas quando houver:

- decisão técnica durável;
- risco novo;
- limitação relevante;
- dívida consciente;
- mudança arquitetural;
- mudança operacional;
- integração nova;
- comando local relevante;
- follow-up estrutural;
- mudança no escopo do MVP.

Não atualizar por:

- ajuste textual simples;
- commit comum;
- status de card;
- mudança trivial;
- detalhe já registrado em Completion Packet;
- nota de sessão.

---

## Declaração final

Este arquivo representa o estado técnico durável do ActHub.

Ele deve ser curto o bastante para ser útil e preciso o bastante para impedir que decisões importantes sejam redescobertas ou distorcidas.