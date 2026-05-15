# LOCAL_COMMANDS — ActHub

## Finalidade

Este documento lista os comandos locais conhecidos e permitidos para trabalhar no ActHub.

Ele existe para impedir que agentes inventem comandos, rodem operações sensíveis sem autorização ou confundam validação real com suposição.

---

## Ambiente esperado

```text
Sistema de desenvolvimento: WSL 2 Ubuntu
Caminho local esperado: ~/projects/acthub
Backend: .NET 8
Frontend: Node.js/npm + Vite/React
Infraestrutura: Terraform
Git: usar Git dentro do WSL, não Git do Windows sobre \\wsl.localhost
```

---

## Regra central

```text
Se o comando não estiver aqui ou não puder ser inferido com segurança de arquivos locais, não trate como autoridade.
```

Quando houver dúvida, investigar antes.

---

## Comandos de localização

```bash
pwd
git status
git branch --show-current
git log --oneline -5
```

---

## Discovery seguro

```bash
find . -maxdepth 2 -type f | sort
find . -maxdepth 3 -type f | sort
```

Usar com parcimônia em repositórios maiores.

---

## Git — leitura segura

```bash
git status
git diff --stat
git diff --check
git diff
git log --oneline -5
git branch --show-current
```

---

## Git — commit

Antes de commit:

```bash
git status
git diff --stat
git diff --check
```

Commit sugerido para documentação de workspace:

```bash
git add .
git commit -m "docs: migrate ActHub workspace context to harness model"
```

---

## Git — operações sensíveis

Exigem cautela e autorização explícita:

```bash
git reset --hard
git clean -fd
git push --force
git rebase
git merge
git branch -D
```

Não usar sem plano e confirmação.

---

## Backend — .NET

### Restaurar dependências

```bash
dotnet restore src/backend/ActHub.sln
```

### Build

```bash
dotnet build src/backend/ActHub.sln
```

### Verify Formatting

```bash
dotnet format src/backend/ActHub.sln --verify-no-changes
```

### Security Check

```bash
dotnet list "$(pwd)/src/backend/ActHub.sln" package --vulnerable --include-transitive
```

### Build sem restore

```bash
dotnet build src/backend/ActHub.sln --no-restore
```

### Listar projetos da solution

```bash
dotnet sln src/backend/ActHub.sln list
```

### Testes

Ainda não há comando de teste consolidado.

Quando projetos de teste forem criados, registrar aqui.

Não inventar comando de teste como se já existisse.

---

## Frontend — React PWA

### Instalar dependências

```bash
npm --prefix src/frontend install
```

Usar apenas quando necessário. Evitar reinstalação sem motivo.

### Build

```bash
npm --prefix src/frontend run build
```

### Type Check

```bash
npm --prefix src/frontend run type-check
```

### Outros scripts

Antes de rodar lint/test/dev, verificar `src/frontend/package.json`.

Não assumir que scripts existem.

---

## Terraform — infraestrutura

Diretório:

```bash
cd infra/terraform
```

### Inicializar

```bash
terraform init
```

### Validar

```bash
terraform validate
```

### Formatar

```bash
terraform fmt
```

### Planejar

```bash
terraform plan
```

`terraform plan` pode depender de variáveis/credenciais locais. Não tratar falha por ausência de variável como falha de código sem investigar.

---

## Terraform — operações sensíveis

Não executar sem autorização explícita:

```bash
terraform apply
terraform destroy
terraform import
terraform state rm
terraform state mv
```

Essas operações podem tocar infraestrutura real e devem ser tratadas como R3/R4 dependendo do ambiente.

---

## Azure

Não executar comandos Azure CLI que alterem recursos sem autorização explícita.

Exemplos sensíveis:

```bash
az group delete
az deployment group create
az resource delete
az keyvault secret set
az webapp restart
az postgres flexible-server delete
```

Leitura pode ser permitida quando houver pergunta clara, mas deve proteger dados sensíveis.

---

## CI/CD

Workflow conhecido:

```text
.github/workflows/backend-build.yml
```

Ele executa em mudanças sob:

```text
src/backend/**
```

Etapas conhecidas:

```text
checkout
setup-dotnet 8.0.x
dotnet restore src/backend/ActHub.sln
dotnet build src/backend/ActHub.sln --no-restore
```

Ainda faltam consolidar pipelines para:

```text
frontend build
static analysis
deploy
terraform validation
```

---

## Validação documental

Para mudanças em Markdown:

```bash
git diff --check
```

Opcional:

```bash
find . -maxdepth 2 -type f | sort
```

Não há linter Markdown obrigatório registrado.

---

## Validação recomendada por tipo de task

### Documentação simples

```bash
git status
git diff --stat
git diff --check
```

### Backend

```bash
dotnet restore src/backend/ActHub.sln
dotnet build src/backend/ActHub.sln
git diff --check
```

### Frontend

```bash
npm --prefix src/frontend install
npm --prefix src/frontend run build
git diff --check
```

Se `node_modules` já existir e dependências não mudaram, avaliar se `install` é necessário.

### Terraform/IaC

```bash
cd infra/terraform
terraform fmt
terraform validate
```

Se `terraform init` for necessário:

```bash
cd infra/terraform
terraform init
terraform validate
```

Não executar `apply` sem autorização.

---

## Comandos proibidos por padrão

```bash
rm -rf
git reset --hard
git clean -fd
git push --force
terraform destroy
terraform apply
az resource delete
az group delete
docker volume rm
curl ... | bash
```

Podem existir exceções, mas exigem autorização explícita, escopo claro e mitigação.

---

## Segredos e arquivos sensíveis

Nunca exibir, copiar ou commitar valores reais de:

```text
tokens
senhas
connection strings
certificados
cookies
headers Authorization
terraform.tfstate
*.tfvars com valores sensíveis
.env
```

Se aparecer segredo:

```text
parar
mascarar
não copiar
escalar
registrar risco sem expor valor
```

---

## Arquivos sensíveis ou de atenção

```text
infra/terraform/*.tf
infra/terraform/*.tfstate
infra/terraform/*.tfvars
.github/workflows/*
.env*
appsettings*.json
```

---

## Relação com agentes

Agentes devem consultar este arquivo antes de propor comandos.

Se um comando necessário não estiver aqui:

1. verificar fonte local;
2. declarar lacuna;
3. propor atualização deste documento;
4. não inventar como autoridade.

---

## Declaração final

Comando é parte da arquitetura operacional.

Um agente que inventa comando está operando fora da verdade local do projeto.