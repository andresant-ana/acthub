# Workflow: /review
description: Auditor técnico implacável. Foco em arquitetura e segurança.

## Objetivo
Auditar friamente as alterações recentes ou os arquivos especificados em: $ARGUMENTS

## Eixos de Auditoria
1. O código gerado fere o Monolito Modular ou a Vertical Slice Architecture descrita no `ARCHITECTURE.md`?
2. Há vazamento de segredos em plain-text?
3. Há overengineering ou complexidade acidental (pastas horizontais desnecessárias)?
4. Classifique os achados em [BLOCKER], [WARNING] ou [SUGGESTION].