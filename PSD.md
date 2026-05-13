# PSD.md — Deprecated

## Status

```text
Estado: deprecated
Substituído por: PROJECT_STATE.md
Cópia histórica preservada em: docs/legacy/PSD.legacy.md
Última atualização de depreciação: 2026-05-13
```

---

## Aviso

Este arquivo não é mais a fonte operacional de estado técnico do ActHub.

O modelo antigo usava `PSD.md` como Project State Document central. Esse modelo foi substituído pela documentação local do harness.

A fonte atual de estado técnico durável é:

```text
PROJECT_STATE.md
```

---

## Onde procurar informação agora

Use:

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
ARCHITECTURE.md
docs/adrs/
docs/product/GTM_STRATEGY.md
docs/product/PROJECT_ROADMAP.md
```

---

## Uso permitido deste arquivo

Este arquivo deve ser usado apenas como ponte de migração.

Para consultar o conteúdo antigo completo, use:

```text
docs/legacy/PSD.legacy.md
```

---

## Uso proibido

Não usar este arquivo para:

- orientar agentes;
- registrar estado atual;
- substituir `PROJECT_STATE.md`;
- rastrear tasks;
- registrar changelog;
- definir próximos passos;
- validar arquitetura;
- comandar OpenCode.

---

## Regra para agentes

Agentes devem ignorar este arquivo como fonte operacional principal.

Se alguma instrução antiga, prompt, issue ou memória pedir para atualizar `PSD.md`, o agente deve:

1. não atualizar este arquivo;
2. consultar `PROJECT_STATE.md`;
3. avaliar se existe memória técnica durável;
4. atualizar `PROJECT_STATE.md` apenas se os critérios forem atendidos;
5. declarar a divergência se necessário.

---

## Declaração final

`PSD.md` foi preservado apenas para compatibilidade histórica.

O estado técnico atual do ActHub vive em `PROJECT_STATE.md`.