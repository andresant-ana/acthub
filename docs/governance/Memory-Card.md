# Memory-Card.md — Deprecated

## Status

```text
Estado: deprecated
Substituído por: documentos locais do harness
Cópia histórica preservada em: docs/legacy/Memory-Card.legacy.md
Última atualização de depreciação: 2026-05-13
```

---

## Aviso

Este arquivo não é mais a memória operacional principal do ActHub.

O antigo Memory Card misturava contexto de produto, arquitetura, estado técnico, decisões, roadmap, GTM, histórico de issues e notas pessoais. Esse formato foi substituído por documentos menores, versionados e com responsabilidade clara.

---

## Fontes atuais

Use os seguintes documentos conforme o tipo de informação:

### Estado técnico

```text
PROJECT_STATE.md
```

### Contexto do projeto

```text
PROJECT_CONTEXT.md
```

### Fontes de autoridade

```text
AUTHORITY_SOURCES.md
```

### Comandos locais

```text
LOCAL_COMMANDS.md
```

### Riscos

```text
RISK_SURFACES.md
```

### Critérios de pronto

```text
DONE_CRITERIA.md
```

### Realidade operacional

```text
OPERATIONAL_REALITY.md
```

### Git, branch e worktree

```text
WORKTREE_POLICY.md
```

### Guia de entrada do workspace

```text
WORKSPACE_GUIDE.md
```

### GitHub Projects e issues

```text
GITHUB_PROJECTS_CONTEXT.md
```

### Arquitetura

```text
ARCHITECTURE.md
docs/adrs/
```

### Produto e GTM

```text
docs/product/GTM_STRATEGY.md
docs/product/PROJECT_ROADMAP.md
```

---

## Conteúdo histórico

Para consultar o conteúdo antigo completo, use:

```text
docs/legacy/Memory-Card.legacy.md
```

---

## Uso permitido deste arquivo

Este arquivo deve ser usado apenas como ponte de migração e orientação histórica.

---

## Uso proibido

Não usar este arquivo para:

- orientar agentes;
- substituir `PROJECT_STATE.md`;
- registrar estado atual;
- registrar changelog;
- comandar OpenCode;
- definir arquitetura vigente;
- definir roadmap vigente;
- decidir prioridade operacional.

---

## Regra para agentes

Agentes devem ignorar este arquivo como fonte operacional principal.

Se uma instrução antiga apontar para `docs/governance/Memory-Card.md`, o agente deve:

1. reconhecer que o arquivo está deprecated;
2. consultar os documentos locais atuais;
3. usar `docs/legacy/Memory-Card.legacy.md` apenas para auditoria histórica;
4. declarar divergência se o legado conflitar com documentos atuais.

---

## Declaração final

O Memory Card antigo foi substituído por uma documentação de workspace compatível com o harness.

A memória técnica atual do ActHub deve ser específica, enxuta e distribuída por responsabilidade.