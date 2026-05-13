# RISK_SURFACES — ActHub

## Finalidade

Este documento mapeia as principais superfícies de risco do ActHub.

Ele deve ser usado pelo Core Architect e por agentes antes de planejar, implementar ou revisar qualquer task relevante.

---

## Regra central

```text
Risco muda comportamento.
```

Uma task que parece pequena pode se tornar sensível se tocar autenticação, autorização, dados, cloud, Terraform, secrets, CI/CD, banco, produção ou boundaries arquiteturais.

---

## Classes de risco usadas

```text
R0 — leitura/investigação sem mutação
R1 — mudança local pequena e reversível
R2 — mudança funcional relevante
R3 — mudança estrutural, sensível ou sistêmica
R4 — produção, segredo, irreversibilidade ou alto risco
```

---

## Superfícies principais

## 1. Autenticação

### Áreas prováveis

```text
ActHub.Modules.Identity
ActHub.Api
configuração de JWT
tiers de assinatura
login
registro
tokens
refresh tokens
```

### Risco padrão

```text
R3
```

Pode virar `R4` se envolver produção, segredo real, token real, dado real ou configuração cloud.

### Cuidados

- não tratar auth como task simples;
- não confiar em validação apenas no frontend;
- não expor tokens;
- não logar credenciais;
- não alterar fluxo de sessão sem plano;
- exigir testes e review.

---

## 2. Autorização

### Áreas prováveis

```text
permissões de personal
permissões de aluno
tiers Starter/Pro/Elite
acesso a recursos por tenant
relação personal-aluno
```

### Risco padrão

```text
R3
```

### Cuidados

- autorização deve ser aplicada no backend;
- frontend não é barreira de segurança;
- mudança exige análise de abuso;
- checar isolamento entre tenants;
- revisar riscos de acesso cruzado.

---

## 3. Multi-tenancy e isolamento de dados

### Áreas prováveis

```text
TenantId
PersonalId
StudentId
vínculos personal-aluno
queries filtradas
logs
analytics
```

### Risco padrão

```text
R3
```

Pode virar `R4` com dados reais.

### Cuidados

- garantir filtro por tenant;
- evitar vazamento entre personal trainers;
- revisar queries de listagem;
- revisar exports futuros;
- revisar logs com IDs e dados sensíveis.

---

## 4. Banco de dados e migrations

### Áreas prováveis

```text
PostgreSQL
EF Core
Dapper
migrations
schemas
queries
índices
constraints
```

### Risco padrão

```text
R2 para schema local simples
R3 para schema estrutural
R4 para migration com dado real/produção
```

### Cuidados

- avaliar dados existentes;
- avaliar rollback;
- evitar migration destrutiva sem aprovação;
- revisar locks;
- revisar constraints;
- validar query shape;
- não aplicar migration real sem autorização.

---

## 5. Execution & Analytics

### Áreas prováveis

```text
ActHub.Modules.Execution
carga
repetições
RIR
RPE
1RM
progressão
histórico
curvas de evolução
```

### Risco padrão

```text
R2/R3
```

### Cuidados

- cálculo errado destrói confiança do produto;
- fórmulas devem ter testes;
- value objects devem proteger invariantes;
- revisar arredondamento;
- revisar unidade de medida;
- revisar histórico;
- evitar alteração silenciosa de algoritmo.

---

## 6. Training Planning

### Áreas prováveis

```text
ActHub.Modules.TrainingPlanning
exercícios
programas
macrociclos
microciclos
sessões
volume planejado
```

### Risco padrão

```text
R2
```

Pode virar `R3` se alterar modelo de domínio central.

### Cuidados

- preservar consistência entre planejamento e execução;
- evitar acoplamento direto com Execution;
- revisar estrutura relacional;
- evitar modelagem excessivamente genérica cedo demais.

---

## 7. CRM & Engagement

### Áreas prováveis

```text
ActHub.Modules.CRM
vínculo personal-aluno
onboarding
churn risk
alertas
engajamento
```

### Risco padrão

```text
R2
```

Pode virar `R3` se envolver eventos inter-módulos ou cálculo crítico de churn.

### Cuidados

- não acoplar diretamente a Execution;
- consumir sinais/eventos quando houver justificativa;
- não antecipar analytics complexo sem dado real;
- separar regra de negócio de notificação.

---

## 8. Bounded Contexts e acoplamento entre módulos

### Áreas prováveis

```text
ActHub.Modules.Identity
ActHub.Modules.CRM
ActHub.Modules.TrainingPlanning
ActHub.Modules.Execution
MediatR
eventos de domínio
ProjectReference
```

### Risco padrão

```text
R3
```

### Cuidados

- não criar `ProjectReference` entre módulos sem decisão explícita;
- não injetar serviço de um módulo em outro;
- não criar shared kernel prematuro;
- eventos devem ter dor real;
- mudanças de boundary exigem ADR/ADR Lite.

---

## 9. Vertical Slice Architecture

### Áreas prováveis

```text
features
handlers
endpoints
commands
queries
validators
pasta por caso de uso
```

### Risco padrão

```text
R2/R3
```

### Cuidados

- evitar horizontalização ritualística;
- não criar `Controllers`, `Services`, `Repositories`, `Core`, `Application`, `Infrastructure` como default;
- exceções exigem dor real e decisão documentada;
- fatias simples devem permanecer simples;
- fatias complexas podem usar domínio rico.

---

## 10. Dependências

### Áreas prováveis

```text
NuGet
npm
MediatR
Polly
Serilog
OpenTelemetry
EF Core
Dapper
libs frontend
```

### Risco padrão

```text
R2
R3 se estrutural
```

### Cuidados

- dependência é complexidade importada;
- não adicionar pacote por conveniência do agente;
- comparar alternativa nativa/local;
- avaliar manutenção;
- avaliar supply chain;
- avaliar impacto em runtime;
- atualizar lockfiles de forma consciente.

---

## 11. Frontend PWA

### Áreas prováveis

```text
src/frontend
React
Vite
TypeScript
PWA
service worker
IndexedDB
offline-first
```

### Risco padrão

```text
R1/R2
```

Pode virar `R3` se envolver offline-first, cache persistente, autenticação ou dados sensíveis no cliente.

### Cuidados

- frontend não é autoridade de segurança;
- cuidado com dados sensíveis em IndexedDB;
- service worker pode gerar bug difícil de diagnosticar;
- cache precisa de invalidação;
- UX deve comunicar falhas.

---

## 12. Infraestrutura Azure

### Áreas prováveis

```text
Resource Group
App Service Plan
PostgreSQL Flexible Server
Azure Key Vault
região brazilsouth
```

### Risco padrão

```text
R3/R4
```

### Cuidados

- alterações podem gerar custo;
- alterações podem tocar recurso real;
- não deletar recurso sem autorização;
- não alterar Key Vault sem autorização;
- não alterar banco real sem plano;
- considerar Free Trial/créditos;
- considerar rollback.

---

## 13. Terraform

### Áreas prováveis

```text
infra/terraform/main.tf
infra/terraform/variables.tf
infra/terraform/outputs.tf
infra/terraform/providers.tf
terraform.tfstate
*.tfvars
```

### Risco padrão

```text
R2 para fmt/validate/local
R3 para plan estrutural
R4 para apply/destroy/state real
```

### Cuidados

- não commitar state;
- não commitar tfvars sensível;
- `terraform apply` exige autorização explícita;
- `terraform destroy` é proibido sem autorização explícita;
- proteger secrets;
- avaliar remote state futuramente.

---

## 14. Secrets e configuração

### Áreas prováveis

```text
Azure Key Vault
connection strings
JWT secrets
db_admin_password
appsettings
.env
CI secrets
Terraform variables
```

### Risco padrão

```text
R4
```

### Cuidados

- nunca copiar valor real para chat;
- nunca commitar;
- nunca logar;
- mascarar sempre;
- se exposto, tratar como comprometido;
- rotação deve ser planejada.

---

## 15. CI/CD

### Áreas prováveis

```text
.github/workflows/backend-build.yml
futuros workflows de frontend
futuros workflows de análise estática
futuros workflows de deploy
```

### Risco padrão

```text
R2 para build/checks
R3 para deploy/secrets/permissões
R4 se tocar produção
```

### Cuidados

- workflows podem expor secrets em logs;
- permissões devem ser mínimas;
- deploy exige gates;
- branch protection deve ser considerada;
- path filters precisam ser revisados;
- CI verde não substitui review.

---

## 16. Observabilidade

### Áreas prováveis

```text
Serilog
OpenTelemetry
Health Checks
logs estruturados
correlation id
Azure diagnostics
```

### Risco padrão

```text
R2/R3
```

### Cuidados

- não logar dados sensíveis;
- observabilidade deve responder a perguntas reais;
- evitar instrumentação ornamental;
- logs precisam ajudar diagnóstico;
- health check deve refletir dependências reais.

---

## 17. Git e histórico

### Áreas prováveis

```text
main
commits
branches
PRs
worktrees
```

### Risco padrão

```text
R1/R2
```

Operações destrutivas sobem risco.

### Cuidados

- não usar `reset --hard` sem autorização;
- não usar `clean -fd` sem autorização;
- não usar `push --force`;
- revisar diff antes de commit;
- não misturar escopos no mesmo commit.

---

## 18. Documentação e estado

### Áreas prováveis

```text
PROJECT_STATE.md
ARCHITECTURE.md
ADRs
docs/product
docs/legacy
workspace docs
```

### Risco padrão

```text
R1/R2
```

Pode virar `R3` se mudar decisão arquitetural.

### Cuidados

- não transformar state em changelog;
- não manter documentos divergentes;
- legado não deve vencer docs novos;
- ADRs devem registrar decisões duráveis;
- evitar documentação ornamental.

---

## Sinais de escalonamento

Escalar quando houver:

- produção;
- segredo;
- dado real;
- Terraform apply/destroy;
- alteração de Key Vault;
- alteração de banco real;
- mudança em auth/authz;
- mudança de boundary;
- dependência estrutural nova;
- mudança em CI/CD com secrets/deploy;
- conflito entre docs e código;
- validação essencial indisponível;
- agente querendo expandir escopo.

---

## Primeiro piloto recomendado

A primeira task piloto do harness no ActHub deve evitar:

- auth;
- autorização;
- banco real;
- Terraform apply;
- Azure real;
- secrets;
- deploy;
- mudança estrutural de arquitetura.

Preferir:

```text
R1/R2 leve
documentação
pipeline local/CI sem segredo
validação estática
ajuste de build
pequena melhoria estrutural com validação clara
```

---

## Declaração final

O ActHub deve crescer com rigor proporcional.

O objetivo não é evitar risco; é enxergar risco antes que o agente trate uma superfície sensível como tarefa comum.