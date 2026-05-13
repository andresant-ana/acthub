# OPERATIONAL_REALITY — ActHub

## Finalidade

Este documento registra a realidade operacional conhecida do ActHub.

Ele deve ser usado para impedir que decisões técnicas sejam tomadas apenas com base em arquitetura idealizada ou funcionamento local parcial.

---

## Regra central

```text
Localhost não é produção.
```

Uma solução só pode ser considerada madura quando ambiente, configuração, build, deploy, observabilidade, dados, secrets e falhas forem considerados de forma proporcional ao risco.

---

## Ambiente de desenvolvimento

Ambiente esperado:

```text
Host: Windows
Ambiente de desenvolvimento: WSL 2 Ubuntu
Diretório esperado: ~/projects/acthub
Git recomendado: Git dentro do WSL
Editor: VS Code/IDE conectado ao WSL
```

Evitar operar Git do Windows diretamente sobre caminho `\\wsl.localhost`.

---

## Backend

Local:

```text
src/backend/
```

Solution:

```text
src/backend/ActHub.sln
```

Runtime:

```text
.NET 8
```

Projetos conhecidos:

```text
ActHub.Api
ActHub.Modules.Identity
ActHub.Modules.CRM
ActHub.Modules.TrainingPlanning
ActHub.Modules.Execution
```

Comandos conhecidos:

```bash
dotnet restore src/backend/ActHub.sln
dotnet build src/backend/ActHub.sln
dotnet sln src/backend/ActHub.sln list
```

Estado atual:

```text
scaffolding estrutural
sem domínio funcional implementado
sem endpoints de negócio implementados
sem persistência funcional implementada
```

---

## Frontend

Local:

```text
src/frontend/
```

Stack:

```text
React
Vite
TypeScript
PWA foundation
npm
```

Comandos conhecidos:

```bash
npm --prefix src/frontend install
npm --prefix src/frontend run build
```

Estado atual:

```text
fundação inicial criada
offline-first ainda não consolidado como feature
service worker/IndexedDB ainda não devem ser assumidos como implementados
```

---

## Infraestrutura

Local:

```text
infra/terraform/
```

Cloud alvo:

```text
Microsoft Azure
```

Recursos conhecidos historicamente:

```text
Resource Group
App Service Plan Linux
PostgreSQL Flexible Server
Azure Key Vault
```

Região registrada:

```text
brazilsouth
```

Comandos locais seguros:

```bash
cd infra/terraform
terraform fmt
terraform validate
```

Comandos condicionais:

```bash
terraform init
terraform plan
```

Comandos sensíveis:

```bash
terraform apply
terraform destroy
terraform import
terraform state rm
terraform state mv
```

Esses comandos sensíveis exigem autorização explícita.

---

## Banco de dados

Banco alvo:

```text
PostgreSQL Flexible Server
```

Estado funcional no código:

```text
persistência ainda não implementada funcionalmente
```

Riscos:

- migrations futuras;
- connection strings;
- secrets;
- estado Terraform;
- dados reais;
- firewall/networking;
- custo cloud.

Banco real ou dados reais elevam risco para R4.

---

## Secrets

Superfícies sensíveis:

```text
db_admin_password
connection strings
JWT secrets
Azure Key Vault
GitHub Actions secrets
Terraform variables
.env
appsettings
terraform.tfstate
*.tfvars
```

Regra:

```text
nunca copiar valor real para chat, log ou commit
```

Se segredo aparecer:

1. parar;
2. mascarar;
3. não repetir o valor;
4. tratar como comprometido quando apropriado;
5. escalar.

---

## CI/CD

Workflow existente:

```text
.github/workflows/backend-build.yml
```

Gatilhos conhecidos:

```text
push em src/backend/**
pull_request em src/backend/**
```

Etapas conhecidas:

```text
checkout
setup-dotnet 8.0.x
dotnet restore src/backend/ActHub.sln
dotnet build src/backend/ActHub.sln --no-restore
```

Lacunas conhecidas:

```text
pipeline frontend ainda não consolidado
pipeline de análise estática ainda pendente
pipeline de deploy ainda pendente
validação Terraform em CI ainda pendente
testes ainda não consolidados
```

---

## Deploy

Estado:

```text
deploy automatizado ainda não consolidado
```

Não assumir que existe pipeline de deploy funcional.

Tasks de deploy devem ser tratadas como sensíveis, especialmente se envolverem:

- secrets;
- Azure;
- produção;
- banco;
- App Service;
- GitHub Environments;
- approvals;
- rollback.

---

## Observabilidade

Planejado:

```text
Serilog
OpenTelemetry
Health Checks
logs estruturados
```

Estado funcional atual:

```text
não assumir como implementado
```

Cuidados futuros:

- logs não devem vazar dados sensíveis;
- health checks devem representar dependências reais;
- tracing deve ser introduzido por dor operacional;
- observabilidade não deve virar ornamentação.

---

## Resiliência

Planejado:

```text
Polly
retry com backoff
circuit breaker
```

Estado funcional atual:

```text
não assumir como implementado
```

Cuidados:

- retry exige idempotência;
- retry sem limite pode piorar falha;
- circuit breaker deve proteger dependência real;
- resiliência deve responder a falhas prováveis, não a cerimônia.

---

## Ambientes

Ambientes formalmente consolidados:

```text
dev/local: parcialmente conhecido
cloud dev: infraestrutura inicial conhecida
staging: não consolidado
production: não consolidado
```

Não usar termo “produção” sem confirmar ambiente real.

---

## FinOps

Riscos conhecidos:

- créditos/free trial Azure;
- SKU de banco;
- região `brazilsouth`;
- custo de recursos persistentes;
- App Service Plan;
- banco gerenciado;
- observabilidade futura.

Qualquer mudança cloud deve considerar custo.

---

## GitHub Projects / Issues

Uso esperado:

```text
coordenação de trabalho
prioridade
status
issue tracking
```

Limite:

```text
GitHub Projects não é fonte de verdade técnica
```

Estado técnico deve estar em:

```text
PROJECT_STATE.md
ARCHITECTURE.md
ADRs
código/configuração
```

---

## Operações proibidas sem autorização explícita

```bash
terraform apply
terraform destroy
az resource delete
az group delete
az keyvault secret set
az webapp restart
git push --force
git reset --hard
git clean -fd
```

---

## Primeira task piloto recomendada

A primeira task com harness/OpenCode deve evitar:

- produção;
- secrets;
- Terraform apply;
- Azure real;
- auth/authz;
- migration;
- deploy.

Preferir:

- documentação;
- pipeline de validação local;
- análise estática sem segredo;
- ajuste de build;
- melhoria pequena e reversível.

---

## Lacunas operacionais atuais

- destino de `PSD.md` ainda pendente;
- destino de `docs/governance/Memory-Card.md` ainda pendente;
- `AGENTS.md` ainda precisa ser atualizado;
- pipelines incompletos;
- testes ainda não estruturados;
- deploy não consolidado;
- observabilidade não implementada;
- resiliência não implementada;
- remote state Terraform ainda não consolidado.

---

## Declaração final

A realidade operacional do ActHub ainda é de fundação.

O projeto tem ambição arquitetural, mas deve avançar incrementalmente, validando comandos, pipelines, riscos e deploy antes de tratar qualquer componente como pronto para produção.