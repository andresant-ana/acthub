# 0002 - Vertical Slice Architecture

## Status
Accepted

## Context
O sistema lida com casos de uso que variam drasticamente em complexidade. O cálculo de progressão de carga e 1RM (Execution Context) exige domínio rico e validações sofisticadas, enquanto as consultas à lista de alunos de um personal trainer (CRM Context) são simples leituras anêmicas (CRUD). A padronização via *Clean Architecture* impõe camadas horizontais (Controllers genéricos, Services anêmicos, Repositories unificados) a todos os fluxos indistintamente. Isso cria "abstrações vazias" e burocracia desnecessária que aumentam o volume de código (boilerplate) sem agregar valor funcional ou de negócio.

## Decision
A arquitetura interna do ActHub adota a **Vertical Slice Architecture** (Arquitetura de Fatias Verticais). Em vez de dividir a aplicação em camadas horizontais, dividimos transversalmente por caso de uso (Use Case). Uma "Fatia Vertical" engloba todo o trajeto necessário (da API ao banco de dados) para entregar uma única funcionalidade. 

## Consequences
- **Positivas:** 
    - Aumenta absurdamente a coesão do código por funcionalidade. Se um dev precisa alterar o fluxo de "Registrar Treino", todos os arquivos relacionados àquela feature coabitam a mesma "fatia", e não em projetos separados.
    - Fim das abstrações inúteis. Fluxos complexos podem usar Domain-Driven Design (DDD) pesado; fluxos simples de leitura podem injetar uma conexão de banco e executar `Dapper` (SQL puro) diretamente no handler, otimizando performance.
- **Negativas:**
    - Pode causar a duplicação intencional e benigna de algumas lógicas periféricas, já que o reaproveitamento indiscriminado de código (Shared/Common) é desestimulado em favor do desacoplamento total da funcionalidade. O reuso ocorre onde faz sentido estratégico, e não apenas para economizar linhas de código.
