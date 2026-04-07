---
description: Elabora o plano tático antes de qualquer modificação estrutural no ActHub.
---

# /plan

Analise o seguinte requisito:

$ARGUMENTS

## Leitura obrigatória antes de responder
1. Leia `~/projects/acthub/ARCHITECTURE.md`
2. Leia `~/projects/acthub/AGENTS.md`

## Objetivo
Produzir um plano de execução tático e arquiteturalmente seguro antes de qualquer implementação.

## Regras obrigatórias
- Não implemente nada.
- Não escreva código.
- Não crie arquivos ainda.
- Não proponha Clean Architecture tradicional.
- Não proponha pastas horizontais como `Controllers`, `Services` ou `Repositories`.
- Respeite integralmente o Monolito Modular e a Vertical Slice Architecture.
- Não antecipe regras de negócio, handlers, endpoints, eventos de domínio ou mensageria se o escopo for apenas scaffolding.
- Se o pedido colidir com `ARCHITECTURE.md`, recuse e explique a violação.
- Se o pedido estiver ambíguo, explicite a hipótese assumida.
- Considere FinOps, estágio do cronograma e risco de complexidade acidental.

## Formato de saída obrigatório
1. Resumo da intenção em até 3 linhas.
2. Classificação da tarefa:
   - scaffolding estrutural
   - implementação de feature
   - infraestrutura
   - revisão
3. Arquivos exatos a serem criados ou modificados, com caminho completo.
4. Impacto arquitetural:
   - bounded context afetado
   - se há risco de acoplamento indevido
   - se há risco de horizontalização
5. Validação de escopo:
   - o pedido pertence à fase atual?
   - está alinhado com a issue informada?
6. Dependências e pré-requisitos.
7. Riscos técnicos e operacionais.
8. Critérios de aceitação.
9. Comandos de validação que o humano deverá executar após a implementação.
10. Status final:
   - `APTO PARA EXECUÇÃO`
   - `BLOQUEADO`
   - `AJUSTE NECESSÁRIO`

## Regra final
Encerre aguardando explicitamente a luz verde humana.