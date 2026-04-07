---
description: Executa revisão fria de diff ou artefatos locais com foco em aderência arquitetural.
agent: reviewer
---

# /review

Revise friamente o diff local ou os arquivos informados em:

$ARGUMENTS

## Leitura obrigatória antes da análise
1. Leia `~/projects/acthub/ARCHITECTURE.md`
2. Leia `~/projects/acthub/AGENTS.md`

## Objetivo
Auditar tecnicamente o que foi produzido e impedir degradação arquitetural, deriva de escopo e violações da esteira oficial do ActHub.

## Regras obrigatórias
- Não reescreva código.
- Não implemente correções.
- Não comente estilo superficial.
- Não elogie.
- Foque apenas em erro estrutural, risco operacional, violação arquitetural ou desalinhamento com a issue.
- Se não houver problema relevante, diga explicitamente que não encontrou blockers.
- Priorize problemas de arquitetura, segurança, desacoplamento, escopo e governança.

## Pontos de auditoria obrigatórios
1. O artefato respeita Monolito Modular?
2. O artefato respeita Vertical Slice Architecture?
3. Há criação indevida de camadas horizontais?
4. Há mistura de scaffolding com regra de negócio?
5. Há bounded contexts acoplados diretamente?
6. Há uso prematuro de MediatR, Polly, Serilog, testes ou domínio rico fora do escopo?
7. Há vazamento de segredo, credencial, string sensível ou configuração insegura?
8. O que foi feito está compatível com a fase atual do cronograma?
9. O que foi feito respeita o objetivo específico da issue?
10. Há risco de overengineering, abstração vazia ou complexidade acidental?

## Formato de saída obrigatório
Para cada achado, use exatamente uma das categorias:
- `[BLOCKER]`
- `[WARNING]`
- `[SUGGESTION]`

Para cada item, informe:
1. Arquivo
2. Problema
3. Por que viola a arquitetura ou o escopo
4. Correção recomendada

## Fechamento obrigatório
Finalize com:
- `Resultado geral: APROVADO`
ou
- `Resultado geral: REPROVADO`

Se reprovar, informe os blockers mínimos que precisam ser corrigidos antes da luz verde humana.