# WORKTREE_POLICY — ActHub

## Finalidade

Este documento define a política local de Git, branch, commit e worktree para o ActHub.

Ele existe para evitar perda de trabalho, mistura de escopos e operações destrutivas feitas por humano ou agente.

---

## Regra central

```text
Uma task deve produzir um diff revisável.
```

Se o diff mistura assuntos demais, a task deve ser quebrada.

---

## Ambiente Git recomendado

Usar Git dentro do WSL:

```bash
cd ~/projects/acthub
git status
```

Evitar operar Git do Windows sobre:

```text
\\wsl.localhost\Ubuntu\home\andre\projects\acthub
```

Isso pode gerar problemas de ownership, path, line endings e autenticação SSH.

---

## Branch principal

Branch principal atual:

```text
main
```

A branch `main` deve ser mantida estável.

---

## Antes de qualquer task

Rodar:

```bash
git status
git branch --show-current
git log --oneline -5
```

Verificar:

- branch correta;
- working tree limpo ou mudanças entendidas;
- se há commits locais pendentes;
- se há arquivos sensíveis no diff;
- se a task deve ser isolada.

---

## Quando criar branch

Criar branch para:

- feature funcional;
- alteração R2+;
- mudança em CI/CD;
- mudança em Terraform;
- mudança arquitetural;
- alteração em auth/authz;
- refactor;
- qualquer task com risco de revisão demorada.

Exemplo:

```bash
git checkout -b docs/harness-workspace-context
```

ou:

```bash
git checkout -b ci/static-analysis
```

---

## Quando pode usar main diretamente

Pode usar `main` diretamente apenas para:

- documentação pequena;
- ajustes locais simples;
- scaffolding controlado;
- correção trivial;
- quando o humano decidir conscientemente.

Mesmo assim, revisar diff antes de commit.

---

## Worktree

Usar worktree quando houver:

- duas tasks paralelas;
- risco de misturar diffs;
- necessidade de testar alternativa;
- task longa;
- mudança R3;
- revisão enquanto outra task continua.

Exemplo:

```bash
git worktree add ../acthub-ci-static-analysis -b ci/static-analysis
```

Remover worktree apenas com cuidado:

```bash
git worktree list
git worktree remove ../acthub-ci-static-analysis
```

---

## Comandos seguros

```bash
git status
git diff --stat
git diff --check
git diff
git log --oneline -5
git branch --show-current
git branch
```

---

## Antes de commit

Rodar:

```bash
git status
git diff --stat
git diff --check
```

Para mudanças de backend, também:

```bash
dotnet build src/backend/ActHub.sln
```

Para mudanças de frontend, também:

```bash
npm --prefix src/frontend run build
```

Para mudanças Terraform, também:

```bash
cd infra/terraform
terraform fmt
terraform validate
```

---

## Mensagem de commit

Formato recomendado:

```text
tipo: descrição causal
```

Tipos comuns:

```text
docs
feat
fix
refactor
test
ci
build
chore
infra
```

Exemplos:

```text
docs: migrate ActHub workspace context to harness model
ci: add backend static analysis pipeline
infra: validate Terraform formatting in CI
feat: add initial identity login slice
```

Evitar:

```text
update
fix stuff
changes
wip
final
```

---

## Commits devem ser causais

Um commit deve representar uma unidade lógica.

Bom:

```text
docs: add workspace authority and state documents
```

Ruim:

```text
docs + terraform + frontend + refactor + pipeline
```

Se houver mais de um motivo, separar.

---

## Operações sensíveis

Não executar sem autorização explícita:

```bash
git reset --hard
git clean -fd
git push --force
git rebase
git merge
git branch -D
```

Essas operações podem perder trabalho ou reescrever histórico.

---

## Pull e push

Antes de push:

```bash
git status
git log --oneline --decorate -5
```

Push padrão:

```bash
git push origin main
```

ou, em branch:

```bash
git push -u origin <branch>
```

Se `git pull` exigir merge ou rebase, parar e avaliar.

---

## Arquivos sensíveis

Nunca commitar:

```text
.env
.env.*
*.tfvars
terraform.tfstate
terraform.tfstate.backup
secrets
connection strings reais
tokens
certificados
node_modules/
bin/
obj/
dist/
```

Confirmar `.gitignore` antes de operações de infra/frontend/backend.

---

## Line endings

Preferir operar dentro do WSL para reduzir ruído de CRLF/LF.

Se aparecer aviso de line endings, revisar se o diff foi alterado apenas por newline antes de commitar.

---

## Relação com agentes

Agente executor deve:

- verificar `git status` antes de mutar;
- declarar arquivos alterados;
- não fazer commit sem autorização;
- não fazer push sem autorização;
- não executar comando destrutivo;
- parar se encontrar diff pré-existente não relacionado.

---

## Diff pré-existente

Se houver mudanças antes da task:

1. identificar arquivos;
2. perguntar se pertencem à task;
3. não sobrescrever;
4. não misturar;
5. sugerir commit separado ou stash somente com autorização.

---

## Stash

`git stash` pode esconder trabalho.

Usar apenas com autorização explícita.

Antes:

```bash
git status
git diff --stat
```

Depois:

```bash
git stash list
```

---

## Critério para PR

Abrir PR quando:

- branch não for main;
- task for R2+;
- houver CI relevante;
- houver review necessário;
- houver risco de regressão;
- houver alteração em CI/CD, infra, auth, banco ou arquitetura.

---

## Relação com GitHub Projects

Board organiza trabalho, mas não valida entrega.

Não mover card automaticamente sem autorização.

Sugestão de status pode ser feita no handoff, com evidência.

---

## Declaração final

Git é parte da segurança operacional do projeto.

Um bom fluxo Git torna a entrega reversível, revisável e auditável. Um fluxo ruim transforma até uma task simples em risco.