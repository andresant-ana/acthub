# PROJECT_STATE — ActHub

## Status

Última atualização: 2026-05-15

Fonte de migração: PSD.md, docs/governance/Memory-Card.md, ARCHITECTURE.md, estado atual do repositório e PR #12

Maturidade: estado inicial migrado para o modelo do harness, com primeira fundação de qualidade em CI concluída

---

## Finalidade

Este documento preserva o estado técnico durável do ActHub.

Ele não é changelog, backlog, board, diário de sessão nem lista de commits.

Registrar aqui apenas informações que precisam sobreviver a sessões futuras porque afetam decisões técnicas, execução, risco, arquitetura ou operação.

---

## Identidade técnica atual

O ActHub é um SaaS B2B2C para gestão, periodização e acompanhamento de treinos, com foco em personal trainers e seus alunos.

A arquitetura alvo combina:

Monólito Modular
Vertical Slice Architecture
Bounded Contexts
.NET 8
React PWA
PostgreSQL
Azure
Terraform
GitHub Actions

---

## Linha de chegada do MVP

A definição formal do MVP está em:

docs/product/MVP_DEFINITION.md

Resumo:

MVP = fluxo privado e funcional para um personal trainer cadastrar alunos, prescrever treinos, permitir execução pelo aluno, registrar histórico e visualizar progressão básica.

O MVP não é lançamento público de SaaS, marketplace, app nativo, billing completo, IA, BI avançado ou plataforma enterprise.

---

## Estado atual resumido

Estado: scaffolding estrutural concluído
Domínio funcional: ainda não implementado
Backend: solution .NET criada
Frontend: fundação React PWA criada
Infraestrutura: Terraform inicial existente
CI/CD: backend build, frontend build, type-check frontend, format check backend, analyzers .NET e NuGet vulnerability check informativo existentes
Documentação local do harness: migração principal concluída
AGENTS.md: migrado para o modelo do harness
MVP: definido em docs/product/MVP_DEFINITION.md
Próxima prioridade registrada: consolidar testes e gates de qualidade antes de domínio funcional sensível

---

## Topologia física atual

src/backend/
ActHub.sln
Directory.Build.props
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
frontend-build.yml

.editorconfig

---

## Documentação operacional atual

Os documentos locais do harness para o ActHub estão criados:

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

O `AGENTS.md` foi migrado para o modelo do harness e agora orienta agentes a usar os documentos locais, não mais `PSD.md` como fonte operacional principal.

---

## Documentos legados

Os documentos abaixo são legados:

PSD.md
docs/governance/Memory-Card.md
docs/legacy/PSD.legacy.md
docs/legacy/Memory-Card.legacy.md

Uso permitido:

histórico
auditoria
recuperação de contexto antigo
comparação durante migração

Uso proibido:

fonte operacional principal
estado técnico atual
comando para agentes
substituto de PROJECT_STATE.md

A verdade operacional atual deve vir dos documentos locais do harness, do código, dos ADRs e das configurações versionadas.

---

## Decisões arquiteturais ativas

### Monólito Modular

Status:

ativo

Decisão:

O ActHub deve iniciar como Monólito Modular, não como microsserviços.

Racional:

* estágio inicial do produto;
* menor custo operacional;
* menor complexidade de deploy;
* menor necessidade de observabilidade distribuída;
* melhor navegabilidade para humano e agentes;
* modularidade lógica ainda preserva evolução futura.

Revisar quando:

* houver escala independente real;
* houver necessidade de deploy independente;
* houver boundary organizacional real;
* o monólito modular gerar dor observável.

---

### Vertical Slice Architecture

Status:

ativo

Decisão:

O ActHub deve organizar funcionalidades por fatias verticais, evitando horizontalização genérica por `Controllers`, `Services`, `Repositories`, `Core`, `Application` e `Infrastructure` como default.

Racional:

* nem todo fluxo tem a mesma complexidade;
* reduz cerimônia;
* aproxima código do caso de uso;
* facilita evolução por feature;
* ajuda o agente a trabalhar com escopo local.

Observação:

A proibição é contra horizontalização ritualística. Exceções podem existir se justificadas por dor real e registradas por ADR.

---

### Bounded Contexts

Status:

ativo

Contexts atuais:

Identity & Access
CRM & Engagement
Training Planning
Execution & Analytics

Regra:

Módulos não devem se acoplar diretamente entre si.

Mudanças que cruzem boundaries devem ser tratadas como sensíveis e provavelmente R3.

---

### Mensageria em memória via MediatR

Status:

decisão arquitetural aceita, ainda não implementada funcionalmente

Decisão:

Comunicação inter-módulos planejada por eventos em memória usando MediatR.

Limite:

Não antecipar eventos, handlers ou infraestrutura de mensageria antes de uma fatia funcional justificar.

---

### Azure + Terraform

Status:

ativo

Decisão:

Infraestrutura declarada via Terraform para Azure.

Recursos conhecidos do histórico:

* Resource Group;
* App Service Plan Linux;
* PostgreSQL Flexible Server;
* Azure Key Vault;
* região `brazilsouth`.

Risco:

Infraestrutura real e secrets elevam risco. Operações `apply`, `destroy`, alteração de Key Vault, banco ou App Service exigem autorização explícita.

---

## ADRs vigentes conhecidos

0001 — Monólito Modular
0002 — Vertical Slice Architecture
0003 — Mensageria em Memória via MediatR
0004 — Infraestrutura em Nuvem Azure com Terraform

Manter `docs/adrs/` como fonte específica de decisões arquiteturais.

---

## Estado do backend

Runtime: .NET 8
Solution: src/backend/ActHub.sln
Host: ActHub.Api
Módulos:
ActHub.Modules.Identity
ActHub.Modules.CRM
ActHub.Modules.TrainingPlanning
ActHub.Modules.Execution

Estado funcional:

sem endpoints de domínio implementados
sem persistência funcional implementada
sem autenticação/autorização funcional implementada
sem MediatR funcional aplicado ao domínio
sem Polly/Serilog/OpenTelemetry/Health Checks funcionais aplicados
sem testes automatizados consolidados

Qualidade/build:

Directory.Build.props criado
EnableNETAnalyzers habilitado
AnalysisMode configurado como Recommended
EnforceCodeStyleInBuild habilitado
dotnet format --verify-no-changes integrado ao backend CI
NuGet vulnerability check informativo integrado ao backend CI

---

## Estado do frontend

Stack: React PWA com Vite/TypeScript
Local: src/frontend/

Estado funcional:

fundação inicial criada
experiência final ainda não implementada
offline-first ainda não implementado
IndexedDB/service workers ainda não consolidados como feature

Qualidade/build:

frontend build consolidado em GitHub Actions
type-check TypeScript adicionado como script local
type-check TypeScript integrado ao frontend CI antes do build

---

## Estado da infraestrutura

Local: infra/terraform/
Cloud alvo: Azure
Banco alvo: PostgreSQL Flexible Server
Região registrada: brazilsouth

Riscos conhecidos:

* Terraform pode tocar recursos reais;
* estado local Terraform é sensível;
* secrets não devem ser expostos;
* Key Vault não elimina risco de estado local;
* alterações cloud exigem plano e autorização.

---

## Estado de CI/CD

Workflows existentes:

.github/workflows/backend-build.yml
.github/workflows/frontend-build.yml

### Backend Build

Função:

build do backend em push/pull_request quando há mudanças em src/backend/**

Checks atuais:

dotnet restore src/backend/ActHub.sln
dotnet build src/backend/ActHub.sln --no-restore
dotnet format src/backend/ActHub.sln --verify-no-changes
dotnet list "$GITHUB_WORKSPACE/src/backend/ActHub.sln" package --vulnerable --include-transitive

Observação:

NuGet vulnerability check é informativo nesta etapa.
Ainda não é security gate bloqueante.

### Frontend Build

Função:

build do frontend em push/pull_request quando há mudanças em src/frontend/**

Checks atuais:

npm ci
npm run type-check
npm run build

### Fundação inicial de análise estática em CI

Status:

ativo — fatia inicial concluída em PR #12

Decisão/estado:

O ActHub possui fundação inicial de qualidade automatizada em CI:

* analyzers .NET habilitados em modo Recommended;
* `.editorconfig` mínimo para line endings e formatação básica;
* `dotnet format --verify-no-changes` no backend;
* NuGet vulnerability check informativo;
* type-check TypeScript no frontend;
* build backend e frontend preservados;
* comandos locais documentados em `LOCAL_COMMANDS.md`.

Limitações:

* ainda não há coverage gate;
* ainda não há security gate bloqueante;
* check de vulnerabilidades NuGet é informativo nesta etapa;
* ainda não há suíte de testes consolidada.

Próxima revisão:

após criação da estrutura inicial de testes e definição de estratégia de coverage/security gate

---

## Estado do MVP

Status:

MVP definido, não implementado

Funcionalidades ainda necessárias para MVP:

Identity & Access mínimo
CRM básico de alunos
catálogo mínimo de exercícios
prescrição de treino
execução de treino pelo aluno
histórico de execução
progressão básica
interface PWA mínima para personal e aluno
operação mínima para piloto controlado

Fora do MVP:

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

---

## Riscos técnicos ativos

### Secrets e Terraform State

Status:

ativo

Houve exposição operacional prévia de credencial em contexto de conversa, tratada por rotação.

Risco permanente:

* não expor secrets;
* não commitar `.tfstate`;
* não commitar `.tfvars` sensível;
* proteger estado local;
* considerar remote state futuramente.

---

### Autenticação e autorização

Status:

não implementado, risco futuro alto

Qualquer task de auth/authz deve ser tratada como sensível.

Classificação provável:

R3

ou `R4` se envolver segredo, produção ou dados reais.

---

### Multi-tenancy e isolamento personal-aluno

Status:

não implementado, risco futuro alto

O MVP precisa impedir acesso cruzado entre personal trainers, alunos e dados de execução.

Classificação provável:

R3

---

### Banco de dados e migrations

Status:

persistência funcional ainda não implementada

Risco:

* migrations com dados reais serão sensíveis;
* schema deve ser pensado com rollback e integridade;
* query shape deve ser revisado.

---

### Cálculos de progressão

Status:

não implementado

Cálculos como volume e 1RM estimado devem ter fórmula explícita e testes.

Erro nessa área prejudica a confiança central do produto.

---

### Cloud e custo

Status:

risco operacional e financeiro conhecido

Há histórico de decisão ligada a região, cota e SKU.

Mudanças de Azure devem considerar:

* custo;
* limites de free trial/créditos;
* região;
* SKU;
* deploy;
* rollback;
* segurança.

---

### CI/CD e gates de qualidade

Status:

fundação inicial criada, gates avançados pendentes

A fundação inicial de análise estática foi criada no PR #12.

Riscos remanescentes:

* ausência de testes automatizados impede coverage gate;
* security check atual é informativo, não bloqueante;
* ainda não há validação Terraform em CI;
* ainda não há deploy pipeline;
* expansão de gates sem testes pode gerar pipeline ornamental ou frágil.

Regra:

Não promover coverage/security gate bloqueante sem antes criar base de testes, validar comandos locais e definir critério de falha proporcional.

---

### Documentação legada

Status:

legado preservado, não operacional

`PSD.md` e `docs/governance/Memory-Card.md` foram substituídos operacionalmente por documentos locais do harness.

Decisão atual:

* manter cópias históricas em `docs/legacy/`;
* manter arquivos legados ativos como stubs de depreciação;
* não usar legados como fonte principal para agentes.

---

## Dívidas técnicas/documentais conscientes

### Decidir remoção futura dos stubs legados

Motivo:

`PSD.md` e `docs/governance/Memory-Card.md` ainda existem na árvore para compatibilidade e orientação histórica.

Ação futura:

Depois de alguns ciclos usando o harness, decidir se:

1. os stubs permanecem;
2. os stubs são removidos;
3. os caminhos antigos são mantidos apenas para referência de migração.

---

### Revisar ARCHITECTURE.md

Motivo:

`ARCHITECTURE.md` é aproveitável e continua sendo fonte arquitetural principal, mas pode conter linguagem mais absoluta que o necessário.

Ação futura:

Revisar termos como “proibido” quando for melhor registrar como “não permitido por padrão salvo ADR explícita”.

---

### Completar pipelines

Pendências conhecidas:

coverage gate
security gate bloqueante
deploy
terraform validation

Observação:

backend build, frontend build, format check backend, type-check frontend e NuGet vulnerability check informativo já existem.

---

### Definir testes

Ainda não há estrutura de testes consolidada.

Ação futura:

* criar projetos de teste para backend;
* definir comando local;
* registrar em `LOCAL_COMMANDS.md`;
* integrar em CI;
* só depois avaliar coverage gate.

---

### Evoluir security gate

O NuGet vulnerability check existe como etapa informativa.

Ação futura:

* decidir critério de severidade;
* avaliar se o comando nativo atende;
* evitar ferramenta externa sem dor real;
* tornar bloqueante apenas quando o critério for claro e validado.

---

## Próximas ações naturais

1. Criar follow-up para estrutura inicial de testes backend.
2. Criar follow-up para coverage gate somente após testes existirem.
3. Criar follow-up para security gate bloqueante, separado de coverage.
4. Avaliar validação Terraform em CI sem `apply`.
5. Avaliar se a próxima task piloto deve continuar em fundação operacional ou iniciar primeira fatia de domínio simples.
6. Manter auth/authz fora das primeiras tasks funcionais até haver base de testes e plano R3.

---

## Critério para atualizar este arquivo

Atualizar `PROJECT_STATE.md` apenas quando houver:

* decisão técnica durável;
* risco novo;
* limitação relevante;
* dívida consciente;
* mudança arquitetural;
* mudança operacional;
* integração nova;
* comando local relevante;
* follow-up estrutural;
* mudança no escopo do MVP.

Não atualizar por:

* ajuste textual simples;
* commit comum;
* status de card;
* mudança trivial;
* detalhe já registrado em Completion Packet;
* nota de sessão.

---

## Declaração final

Este arquivo representa o estado técnico durável do ActHub.

Ele deve ser curto o bastante para ser útil e preciso o bastante para impedir que decisões importantes sejam redescobertas ou distorcidas.
