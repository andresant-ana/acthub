---
name: dotnet-solution-scaffolding
description: >
  Use OBRIGATORIAMENTE quando a tarefa envolver a criação ou organização da
  estrutura inicial da Solution .NET do ActHub, sem implementar regra de negócio.
---

# Skill: Dotnet Solution Scaffolding

## Objetivo
Esta skill existe para guiar o scaffolding estrutural do back-end do ActHub em C# .NET 8,
respeitando o Monolito Modular e a Vertical Slice Architecture, sem antecipar
implementações de domínio, autenticação, persistência real ou mensageria.

## Quando usar
Use esta skill quando a tarefa envolver:
- criação da Solution `.sln`;
- criação de projetos base do back-end;
- organização inicial de diretórios e módulos;
- preparação estrutural para os Bounded Contexts;
- definição de esqueleto físico sem regra de negócio.

## Quando NÃO usar
Não use esta skill para:
- criar handlers, commands, queries ou endpoints funcionais;
- implementar autenticação JWT;
- escrever entidades, agregados ou objetos de valor;
- configurar MediatR em fluxos reais;
- implementar acesso a dados com EF Core ou Dapper;
- criar testes de domínio;
- modelar fórmulas matemáticas de treino;
- criar comunicação entre contextos.

Nesses casos, a tarefa já saiu do escopo de scaffolding.

## Regras arquiteturais invioláveis
1. O ActHub é um Monolito Modular.
2. O padrão interno é Vertical Slice Architecture.
3. É proibido criar estruturas horizontais como:
   - `Controllers`
   - `Services`
   - `Repositories`
   - `Core`
   - `Application`
   - `Infrastructure`
4. Os Bounded Contexts devem permanecer explícitos e isolados:
   - Identity
   - CRM
   - TrainingPlanning
   - Execution
5. Scaffolding não é autorização para escrever regra de negócio.
6. Se o plano tentar puxar implementações da Fase 2, pare e reporte.

## Meta estrutural esperada
A skill deve favorecer uma estrutura inicial compatível com:
- uma Solution principal do ActHub;
- um projeto de entrada HTTP para a API;
- módulos separados por Bounded Context;
- diretórios preparados para futura evolução por fatias verticais;
- projetos de teste apenas se o plano exigir scaffolding de testes, sem inventar cenários.

## Diretrizes de modelagem física
- O projeto de entrada deve ser mínimo e limpo.
- Os módulos devem nascer organizados por contexto, não por camada.
- Evite criar arquivos vazios em excesso apenas para “parecer enterprise”.
- Crie somente o necessário para a estrutura respirar.
- Todo nome técnico deve estar em Inglês.

## Restrições de implementação
Durante o scaffolding, NÃO:
- implemente domínio;
- adicione lógica de autenticação;
- configure persistência real;
- escreva migrations;
- configure pipelines de observabilidade;
- adicione Polly, Serilog, OpenTelemetry ou Health Checks;
- dispare ou registre eventos de domínio reais.

Esses temas pertencem a etapas posteriores do cronograma.

## Formato de entrega esperado
Ao usar esta skill, o agente deve:
1. informar os caminhos completos dos arquivos e diretórios;
2. gerar apenas a estrutura necessária para a task aprovada;
3. explicar brevemente a função de cada projeto criado;
4. informar os comandos mínimos de validação estrutural.

## Comandos de validação sugeridos
Use apenas se fizer sentido para o plano aprovado:

```bash
dotnet --version
dotnet new sln --help
dotnet sln list
dotnet build
```

## Regra final
Se o pedido ultrapassar scaffolding estrutural e entrar em implementação funcional,
interrompa e reporte que a skill correta para a próxima etapa ainda não foi acionada.