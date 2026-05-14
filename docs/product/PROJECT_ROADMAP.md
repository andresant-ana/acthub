# PROJECT_ROADMAP — ActHub

## Finalidade

Este documento registra o roadmap macro do ActHub.

Ele não substitui GitHub Projects, issues, PRs, ADRs, `PROJECT_STATE.md` ou `MVP_DEFINITION.md`.

Sua função é orientar sequência estratégica, não rastrear cada tarefa granular.

---

## Fontes relacionadas

```text
PROJECT_STATE.md
docs/product/MVP_DEFINITION.md
docs/product/GTM_STRATEGY.md
ARCHITECTURE.md
docs/adrs/
```

---

## Estado atual migrado

```text
Fase atual: Fundação técnica / preparação para qualidade e CI/CD
Estado técnico: scaffolding estrutural concluído
Domínio funcional: ainda não implementado
Documentação local do harness: migração principal concluída
AGENTS.md: migrado para o modelo do harness
MVP: definido em docs/product/MVP_DEFINITION.md
Próxima prioridade conhecida: fundação de qualidade antes de domínio funcional
```

---

## Linha macro

```text
Fundação operacional
↓
Qualidade e testes
↓
Primeira persistência controlada
↓
Identity & CRM mínimo
↓
Prescrição de treino
↓
Execução do treino
↓
Histórico e progressão básica
↓
Piloto controlado
```

---

# Fase 0 — Harness, documentação e prontidão do workspace

## Objetivo

Preparar o ActHub para trabalho governado com Core Architect + OpenCode.

## Estado

```text
concluída na migração principal
```

## Entregas

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
AGENTS.md migrado
```

## Pendência residual

```text
observar se stubs legados continuam necessários após alguns ciclos de uso
```

---

# Fase 1 — Fundação, infraestrutura e governança

## Objetivo

Criar base técnica antes de escrever regra de negócio.

A lógica da fase é:

```text
primeiro ambiente, governança, infraestrutura, CI/CD e scaffolding;
depois domínio funcional.
```

## Itens históricos

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

## Estado conhecido

Concluído ou parcialmente concluído segundo estado migrado:

```text
scaffolding .NET/React
estrutura src/backend e src/frontend
infra Terraform inicial
backend build workflow
ADRs iniciais
documentação local do harness
AGENTS.md atualizado para modelo do harness
```

Ainda pendente/precisa confirmar:

```text
pipeline de análise estática
pipeline de deploy
validação Terraform em CI
pipeline frontend
testes automatizados
```

---

# Fase 2 — Qualidade, testes e validação local

## Objetivo

Criar a base mínima para desenvolver domínio funcional sem depender de confiança textual.

## Entregas esperadas

```text
pipeline de análise estática
pipeline frontend build
validação Terraform em CI
estrutura inicial de testes backend
convenção de testes
comandos de teste registrados em LOCAL_COMMANDS.md
```

## Por que vem antes do domínio

O MVP tocará áreas sensíveis:

```text
auth/authz
dados de aluno
vínculo personal-aluno
migrations
cálculos de progressão
```

Sem build, testes e validação local, o risco de slop e regressão sobe cedo demais.

## Candidatos para primeiro piloto com agente

```text
pipeline de análise estática
pipeline frontend build
validação Terraform em CI
estrutura inicial de testes backend
```

## Evitar nesta fase

```text
auth/authz
Terraform apply
deploy real
migration com dado real
mudança arquitetural estrutural
```

---

# Fase 3 — Base de domínio e persistência mínima

## Objetivo

Criar a primeira base funcional do backend sem inflar arquitetura.

## Entregas esperadas

```text
persistência local controlada
modelo inicial de entidades
primeira migration local
primeira fatia vertical simples
testes para regra mínima
convenção de input validation
```

## Escopo provável

Começar por área de menor risco que auth/authz.

Candidatos:

```text
catálogo mínimo de exercícios
estrutura inicial de aluno sem auth completa
primeira entidade de treino sem execução real
```

## Cuidados

- não criar repository genérico por ritual;
- não criar abstração antes de dor real;
- não acoplar módulos diretamente;
- migrations locais exigem rollback mental;
- dado real eleva risco.

---

# Fase 4 — Identity & CRM mínimo

## Objetivo

Permitir que personal e aluno existam no sistema com vínculo seguro.

## Entregas esperadas

```text
cadastro/login básico
perfil de personal
perfil de aluno
vínculo personal-aluno
CRUD mínimo de alunos
autorização backend básica
proteção contra acesso cruzado
```

## Risco

```text
R3
```

Auth/authz é superfície sensível e precisa de plano forte, validação e review.

## Fora do escopo nesta fase

```text
SSO
MFA
billing
tiers completos
admin enterprise
RBAC complexo
```

---

# Fase 5 — Prescrição de treino

## Objetivo

Permitir que o personal crie e atribua treinos para alunos.

## Entregas esperadas

```text
catálogo mínimo de exercícios
criação de treino
edição de treino
exercícios do treino
séries
repetições alvo
carga alvo opcional
RIR/RPE alvo opcional
observações
atribuição para aluno
visualização do treino
```

## Fora do escopo

```text
periodização avançada
macrociclos completos
templates complexos
prescrição coletiva
automação inteligente
```

## Critério de avanço

Um personal consegue prescrever um treino real sem depender de planilha externa.

---

# Fase 6 — Execução do treino pelo aluno

## Objetivo

Permitir que o aluno registre uma sessão real de treino.

## Entregas esperadas

```text
tela de treino do aluno
início de sessão
registro por exercício
carga realizada
repetições realizadas
RIR/RPE realizado quando aplicável
finalização de sessão
persistência do histórico
```

## Fora do escopo

```text
offline-first completo
wearables
chat
mídia
timer avançado
```

## Critério de avanço

Uma sessão real consegue ser registrada do início ao fim.

---

# Fase 7 — Histórico e progressão básica

## Objetivo

Mostrar valor técnico ao personal por meio de histórico e evolução.

## Entregas esperadas

```text
histórico por aluno
histórico por exercício
última execução
evolução de carga
evolução de repetições
volume básico
1RM estimado, se houver fórmula testada
visualização simples
```

## Cuidados

- cálculo errado destrói confiança;
- fórmulas devem ser explícitas;
- testes são obrigatórios para cálculo crítico;
- não implementar analytics avançado cedo demais.

---

# Fase 8 — Piloto controlado

## Objetivo

Validar valor real com um personal trainer e poucos alunos.

## Entregas esperadas

```text
ambiente controlado
fluxo de uso documentado
feedback do personal
feedback de alunos
registro de fricções
lista de correções pós-piloto
decisão sobre próxima fase
```

## Critério de sucesso

O personal consegue usar o ActHub para acompanhar alunos reais ou semi-reais e perceber valor acima do método atual.

---

# Fase 9 — Pós-MVP

## Objetivo

Decidir o que entra depois com base no aprendizado do piloto.

## Candidatos futuros

```text
billing
tiers reais
afiliados
offline-first completo
push notifications
dashboards avançados
churn prediction
automação de progressão
integrações
produção pública
```

Nenhum desses itens deve ser antecipado sem evidência de dor real.

---

## Ordem técnica imediata recomendada

```text
1. Commitar MVP_DEFINITION.md e ajustes de state/roadmap
2. Rodar primeiro piloto técnico com task pequena
3. Implementar pipeline de análise estática
4. Implementar pipeline frontend build
5. Implementar validação Terraform em CI
6. Criar estrutura inicial de testes backend
7. Iniciar primeira fatia funcional simples
8. Planejar Identity/Auth com tratamento R3
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
- próxima fase resolve dor real;
- a fase seguinte contribui diretamente para o MVP.

---

## Critério de revisão do roadmap

Atualizar este documento quando houver:

- mudança macro de prioridade;
- nova fase;
- conclusão real de marco relevante;
- decisão de produto durável;
- mudança de GTM;
- mudança de arquitetura que afete sequência;
- mudança no escopo do MVP;
- aprendizado de piloto real.

Não atualizar para cada commit ou issue pequena.

---

## Declaração final

O roadmap do ActHub deve proteger sequência e foco.

A ambição é construir um produto tecnicamente forte, mas o caminho precisa permanecer incremental, validável e proporcional ao estágio real do projeto.