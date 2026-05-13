# PROJECT_STATE — ActHub

## Status

```text
Última atualização: 2026-05-12
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

## Estado atual resumido

```text
Estado: scaffolding estrutural concluído
Domínio funcional: ainda não implementado
Backend: solution .NET criada
Frontend: fundação React PWA criada
Infraestrutura: Terraform inicial existente
CI/CD: pipeline backend build existente
Próxima prioridade registrada: pipeline de análise estática / shift-left
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

.github/workflows/
  backend-build.yml
```

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

### Agentes e documentação legada

Status:

```text
migração em andamento
```

`AGENTS.md`, `PSD.md` e `docs/governance/Memory-Card.md` ainda refletem o modelo antigo.

Decisão atual:

- documentos legados foram preservados em `docs/legacy/`;
- novos documentos do harness passam a ser fonte operacional principal;
- `AGENTS.md` será atualizado em onda posterior.

---

## Dívidas técnicas/documentais conscientes

### Atualizar AGENTS.md

Motivo:

`AGENTS.md` ainda exige uso de `PSD.md` e atualização obrigatória de PSD após toda task.

Ação futura:

Migrar para o modelo:

```text
ler workspace docs
usar PROJECT_STATE.md com parcimônia
não transformar state em changelog
seguir harness
```

---

### Decidir destino de PSD.md

Motivo:

`PSD.md` é legado e foi substituído conceitualmente por `PROJECT_STATE.md`.

Ação futura:

Após validação da migração, decidir se:

```text
1. PSD.md será removido;
2. PSD.md será transformado em ponte apontando para PROJECT_STATE.md;
3. PSD.md ficará temporariamente congelado como legado.
```

---

### Decidir destino de Memory-Card.md

Motivo:

`docs/governance/Memory-Card.md` mistura decisões, estado, GTM, histórico, contexto pessoal e issues.

Ação futura:

Após migração, decidir se:

```text
1. será removido;
2. será congelado como legado;
3. será substituído por documentos menores.
```

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

1. Preencher todos os documentos locais do harness.
2. Atualizar `AGENTS.md`.
3. Revisar `ARCHITECTURE.md` para remover linguagem excessivamente absoluta onde necessário.
4. Subir fontes limpas no Project ActHub.
5. Escolher primeira task piloto pequena.
6. Gerar prompt para OpenCode usando o Core Architect.
7. Rodar piloto com Completion Packet e Review Report.

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
- follow-up estrutural.

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