---
description: Planejar a estrutura inicial da Issue #10 do ActHub com foco exclusivo em scaffolding da Solution .NET 8 e do esqueleto React PWA, sem implementar regra de negócio.
---

# OBJETIVO
Planejar a estrutura inicial da Issue #10 do ActHub com foco exclusivo em scaffolding da Solution .NET 8 e do esqueleto React PWA, sem implementar regra de negócio.

# LEITURA OBRIGATÓRIA
Antes de responder:
1. Leia `ARCHITECTURE.md`
2. Leia `AGENTS.md`

# REGRAS DE EXECUÇÃO OBRIGATÓRIAS
1. Não escreva código final.
2. Não crie handlers, commands, queries, endpoints ou eventos.
3. Não proponha Clean Architecture tradicional.
4. Não crie pastas horizontais como:
   - Controllers
   - Services
   - Repositories
   - Core
   - Application
   - Infrastructure
5. Não implemente autenticação, banco, EF Core, Dapper, MediatR funcional, Polly, Serilog, OpenTelemetry, testes de domínio, IndexedDB funcional ou sincronização offline.
6. Trate a tarefa como scaffolding estrutural puro.

# SAÍDA OBRIGATÓRIA
Entregue exatamente nesta ordem:

1. Resumo da intenção em até 3 linhas.
2. Classificação da tarefa:
   - scaffolding estrutural
3. Estrutura de diretórios proposta para o back-end.
4. Estrutura de diretórios proposta para o front-end.
5. Lista exata de arquivos e projetos que deverão existir após a Issue #10.
6. Riscos de horizontalização ou overengineering.
7. Critérios de aceitação da Issue #10.
8. O que explicitamente NÃO deve ser implementado nesta issue.
9. Checklist de validação humana antes da execução física.
10. Encerramento com:
   - `APTO PARA EXECUÇÃO NO OPENCODE`
   ou
   - `BLOQUEADO`

# REGRA FINAL
Se a proposta começar a parecer implementação funcional, interrompa e rebaixe o escopo para scaffolding.