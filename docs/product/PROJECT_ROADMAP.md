# PROJECT_ROADMAP — ActHub

## Finalidade

Este documento registra o roadmap macro do ActHub.

Ele não substitui GitHub Projects, issues, PRs, ADRs ou `PROJECT_STATE.md`.

Sua função é orientar sequência estratégica, não rastrear cada tarefa granular.

---

## Estado atual migrado

```text
Fase atual: Fundação técnica / preparação para qualidade e CI/CD
Estado técnico: scaffolding estrutural concluído
Domínio funcional: ainda não implementado
Próxima prioridade conhecida: pipeline de análise estática / shift-left
```

---

## Fase 1 — Fundação, infraestrutura e governança

### Objetivo

Criar base técnica antes de escrever regra de negócio.

A lógica da fase é:

```text
primeiro ambiente, governança, infraestrutura, CI/CD e scaffolding;
depois domínio funcional.
```

### Itens históricos

```text
Issue #1  — Setup de ambiente Linux/WSL
Issue #2  — Configuração Git/SSH
Issue #3  — ADRs e diretrizes de IA
Issue #4  — IaC Resource Group e App Service Plan
Issue #5  — IaC PostgreSQL Flexible Server
Issue #6  — Azure Key Vault
Issue #7  — Pipeline de Build
Issue #8  — Pipeline de Análise Estática
Issue #9  — Pipeline de Deploy
Issue #10 — Scaffolding .NET e React PWA
```

### Estado conhecido

Concluído ou parcialmente concluído segundo estado migrado:

```text
scaffolding .NET/React
estrutura src/backend e src/frontend
infra Terraform inicial
backend build workflow
ADRs iniciais
```

Ainda pendente/precisa confirmar:

```text
pipeline de análise estática
pipeline de deploy
validação Terraform em CI
pipeline frontend
testes automatizados
atualização do AGENTS.md para harness novo
```

---

## Fase 2 — Núcleo backend e domínio mínimo

### Objetivo

Criar o backend funcional mínimo, mantendo Monólito Modular e Vertical Slice Architecture.

### Áreas

```text
Identity & Access
Execution & Analytics
Training Planning
CRM & Engagement
mensageria em memória quando justificada
persistência PostgreSQL
```

### Ordem recomendada

Não iniciar pelo domínio mais complexo sem base de segurança e testes.

Ordem provável:

1. estrutura de testes;
2. primeira fatia simples não sensível;
3. persistência mínima;
4. modelagem inicial de usuário/personal/aluno;
5. auth/authz com plano forte;
6. primeiros cálculos de Execution com testes;
7. eventos inter-módulos só quando houver caso real.

### Cuidados

- auth/authz é R3;
- migrations com dado real são R4;
- Execution & Analytics exige testes fortes;
- MediatR não deve ser antecipado sem fluxo real;
- não criar abstrações genéricas por estética.

---

## Fase 3 — Experiência PWA e fluxo do aluno

### Objetivo

Criar experiência de baixa fricção para aluno e personal.

### Áreas

```text
React PWA
interface de aluno
interface de personal
registro de treino
histórico básico
visualização de evolução
```

### Offline-first

Offline-first é desejável, mas não deve virar complexidade prematura.

Implementar quando houver:

- fluxo real de uso;
- dado local necessário;
- regra de sincronização;
- risco de conflito entendido;
- testes mínimos.

### Cuidados

- dados sensíveis no cliente;
- IndexedDB;
- cache;
- service worker;
- invalidação;
- autenticação no frontend;
- UX de erro/loading.

---

## Fase 4 — Resiliência, observabilidade e prontidão operacional

### Objetivo

Preparar o sistema para uso real com diagnóstico, falha controlada e operação mínima.

### Áreas

```text
Serilog
OpenTelemetry
Health Checks
Polly
config por ambiente
deploy
rollback
monitoramento
```

### Cuidados

- observabilidade deve responder perguntas reais;
- logs não podem vazar dados sensíveis;
- retry exige idempotência;
- health check deve refletir dependências reais;
- deploy sem rollback é risco.

---

## Fase 5 — Validação de mercado e GTM

### Objetivo

Validar valor com usuário real e aprender antes de escalar comercialmente.

### Áreas

```text
paciente zero
prospecção B2B
ativação inicial
pricing
feedback loop
métricas de uso
retenção
afiliados, se houver tração
```

### Cuidados

- não automatizar comercial antes de produto utilizável;
- não implementar afiliados cedo demais;
- não inflar dashboard de métricas sem uso real;
- não sacrificar qualidade do core de treino por cosmética.

---

## Roadmap técnico imediato

### 1. Completar migração documental para harness

Status:

```text
em andamento
```

Inclui:

```text
PROJECT_CONTEXT.md
AUTHORITY_SOURCES.md
LOCAL_COMMANDS.md
PROJECT_STATE.md
RISK_SURFACES.md
DONE_CRITERIA.md
OPERATIONAL_REALITY.md
WORKTREE_POLICY.md
WORKSPACE_GUIDE.md
GITHUB_PROJECTS_CONTEXT.md
docs/product/GTM_STRATEGY.md
docs/product/PROJECT_ROADMAP.md
AGENTS.md atualizado
```

### 2. Atualizar AGENTS.md

Objetivo:

Migrar de modelo antigo baseado em `PSD.md` para modelo novo baseado em harness local.

Mudança principal:

```text
não sobrescrever PSD após toda task
avaliar PROJECT_STATE apenas quando houver memória técnica durável
```

### 3. Escolher primeira task piloto

Características:

```text
pequena
real
reversível
validável
sem segredo
sem produção
sem auth/authz
sem Terraform apply
```

Candidatos prováveis:

- análise estática;
- pipeline frontend build;
- validação Terraform em CI;
- documentação operacional;
- ajuste de workflow sem deploy.

### 4. Rodar piloto com Core Architect + OpenCode

Fluxo:

```text
Core Architect
↓
Execution Plan / prompt
↓
OpenCode
↓
Completion Packet
↓
Review
↓
state decision
```

---

## Ordem sugerida de issues futuras

A ordem exata deve ser confirmada no GitHub Projects, mas a sequência técnica recomendada é:

```text
1. Pipeline de análise estática
2. Pipeline frontend build
3. Validação Terraform em CI
4. Estrutura inicial de testes backend
5. Primeira fatia backend simples
6. Primeira persistência local controlada
7. Identity/Auth com plano forte
8. Execution calculation com testes
9. Training planning mínimo
10. CRM básico
```

---

## Fora do escopo imediato

Não priorizar agora:

```text
microsserviços
Kubernetes
deploy complexo
event sourcing
CQRS global
offline-first completo
afiliados
BI avançado
churn prediction sofisticado
IA generativa
produção real sem maturidade operacional
```

---

## Critério de avanço entre fases

Avançar de fase apenas quando:

- objetivo técnico da fase anterior está minimamente validado;
- comandos locais estão documentados;
- CI relevante existe;
- riscos principais estão mapeados;
- state está atualizado com decisões duráveis;
- não há pendência crítica de segurança;
- próxima fase resolve dor real.

---

## Critério de revisão do roadmap

Atualizar este documento quando houver:

- mudança macro de prioridade;
- nova fase;
- conclusão real de marco relevante;
- decisão de produto durável;
- mudança de GTM;
- mudança de arquitetura que afete sequência;
- aprendizado de piloto real.

Não atualizar para cada commit ou issue pequena.

---

## Declaração final

O roadmap do ActHub deve proteger sequência e foco.

A ambição é construir um produto tecnicamente forte, mas o caminho precisa permanecer incremental, validável e proporcional ao estágio real do projeto.