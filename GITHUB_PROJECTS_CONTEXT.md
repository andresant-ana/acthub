# GITHUB_PROJECTS_CONTEXT — ActHub

## Finalidade

Este documento define como GitHub Issues e GitHub Projects devem ser usados no ActHub.

O board organiza trabalho.  
Ele não substitui código, ADR, documentação local, validação ou `PROJECT_STATE.md`.

---

## Regra central

```text
GitHub Projects coordena.
PROJECT_STATE.md preserva verdade técnica.
```

---

## Uso permitido

GitHub Issues e Projects podem ser usados para:

- prioridade;
- status;
- sequencing;
- escopo inicial;
- critérios de aceite;
- dependências;
- discussão de task;
- vínculo com PR;
- histórico de coordenação.

---

## Limite

GitHub Issues e Projects não provam:

- que a implementação está correta;
- que validação foi executada;
- que arquitetura foi respeitada;
- que a task está tecnicamente pronta;
- que `PROJECT_STATE.md` deve ser atualizado;
- que produção está segura.

Status `Done` não substitui Completion Packet, Review Report, build, teste ou review humano.

---

## Relação entre issue e execução

Uma issue pode iniciar uma task, mas antes de implementação relevante deve virar:

```text
Implementation Packet
Execution Plan
Prompt para executor
```

Issue com título bom ainda não é plano.

---

## Relação entre board e PROJECT_STATE

Board registra coordenação.

Exemplo adequado para board:

```text
Issue #8 está em progresso.
Issue #10 foi concluída.
Pipeline de análise estática é próxima prioridade.
```

`PROJECT_STATE.md` registra estado técnico durável.

Exemplo adequado para state:

```text
Backend possui pipeline de build em .github/workflows/backend-build.yml, disparado por mudanças em src/backend/**.
```

---

## Status esperados

Os nomes exatos podem variar conforme o Project configurado, mas o significado operacional deve seguir esta lógica:

```text
Backlog      → ideia/task ainda não pronta para execução
Ready        → task pronta para intake/planejamento
In Progress  → execução ou planejamento em andamento
Review       → precisa de review técnico/humano
Done         → concluída em coordenação, não necessariamente fonte técnica
Blocked      → impedimento explícito
```

Se o board usar nomes diferentes, registrar aqui em atualização futura.

---

## Issues conhecidas do roadmap legado

O histórico do projeto registra as seguintes issues de fundação:

```text
Issue #1  — Setup de ambiente Linux/WSL
Issue #2  — Configuração de identidade e criptografia Git/SSH
Issue #3  — ADRs e diretrizes de IA no workspace
Issue #4  — IaC: Resource Group e App Service Plan Azure
Issue #5  — IaC: PostgreSQL Flexible Server
Issue #6  — IaC: Azure Key Vault
Issue #7  — CI/CD: Pipeline de Build
Issue #8  — CI/CD: Pipeline de Análise Estática
Issue #9  — CI/CD: Pipeline de Deploy
Issue #10 — Scaffolding .NET e React PWA
```

Estado migrado conhecido:

```text
Issue #10 concluída
Issue #7 associada ao pipeline backend build inicial
Issue #8 indicada como prioridade atual
Issue #9 ainda pendente
```

Confirmar no board antes de usar como verdade de coordenação atual.

---

## Como consultar board/issues

Quando houver MCP ou consulta externa disponível, usar apenas modo read-only por padrão.

Permitido:

- ler issue;
- ler descrição;
- ler comentários;
- ler labels;
- ler milestone;
- ler status;
- ler PR vinculado;
- resumir critérios de aceite.

Proibido sem autorização explícita:

- mover card;
- fechar issue;
- reabrir issue;
- comentar;
- aplicar label;
- alterar milestone;
- atribuir responsável;
- editar campo;
- arquivar item.

---

## Quando usar GitHub Projects

Consultar board/issues quando:

- a task veio do board;
- prioridade estiver incerta;
- critérios de aceite estiverem na issue;
- for preciso saber dependências;
- for preciso preparar handoff;
- for preciso sugerir próximo status;
- houver divergência entre conversa e coordenação formal.

---

## Quando não usar GitHub Projects

Não consultar board quando:

- a resposta está no repo;
- a questão é puramente técnica local;
- a consulta seria curiosidade;
- o board não altera decisão;
- o objetivo é validar código;
- a questão é estado técnico já registrado em `PROJECT_STATE.md`.

---

## Sugestão de atualização de board

Agentes podem sugerir atualização, mas não executar sem autorização.

Formato recomendado:

```text
Item:
Status atual:
Status sugerido:
Motivo:
Evidência:
Lacunas:
Ação humana necessária:
```

---

## Critérios para sugerir Done

Só sugerir `Done` quando houver:

- objetivo atendido;
- escopo respeitado;
- validação executada;
- Completion Packet;
- Review Report quando necessário;
- lacunas não bloqueantes declaradas;
- decisão sobre `PROJECT_STATE.md`;
- commit/PR vinculado quando aplicável.

---

## Divergência entre board e repo

Se o board disser uma coisa e o repo disser outra:

1. declarar divergência;
2. não corrigir automaticamente;
3. verificar fonte mais específica;
4. sugerir atualização humana;
5. registrar em state apenas se houver impacto técnico durável.

Exemplos:

```text
Board diz Done, mas workflow não existe.
Issue diz pipeline concluído, mas .github/workflows não confirma.
PROJECT_STATE diz pendente, mas código mostra implementação.
```

---

## Relação com PRs

PR pode conter:

- diff;
- discussão;
- review;
- CI;
- decisão de merge.

Mas PR aprovado não substitui análise local se a task for sensível.

Para R2+:

```text
PR + CI verde + Review Report é melhor que PR sozinho.
```

---

## Declaração final

GitHub Projects é ferramenta de coordenação.

O ActHub deve evitar transformar board em memória técnica, e evitar transformar `PROJECT_STATE.md` em espelho do board.