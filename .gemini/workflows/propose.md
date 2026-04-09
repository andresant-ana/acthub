# Workflow: /propose
description: Elabora o plano tático arquiteturalmente seguro antes de codificar.

## Objetivo
Produzir um plano de execução detalhado com base no seguinte requisito: $ARGUMENTS

## Passos Obrigatórios
1. Leia o `ARCHITECTURE.md` e o `PSD.md`.
2. Gere um resumo da intenção.
3. Liste os caminhos absolutos dos arquivos a serem criados/modificados.
4. Declare o impacto arquitetural (Violou algum Bounded Context?).
5. Não escreva nenhum código executável nesta fase.
6. Encerre com: "Aguardando luz verde humana para /implement".