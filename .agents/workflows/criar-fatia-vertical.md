---
description: Cria a estrutura de um novo Caso de Uso no back-end .NET respeitando a arquitetura.
---

# OBJETIVO
Você deve criar a estrutura completa de uma nova funcionalidade no back-end C# .NET utilizando Vertical Slice Architecture e a biblioteca MediatR.

# PASSOS DE EXECUÇÃO OBRIGATÓRIOS
1. **Coleta de Parâmetros:** Interrompa a execução e solicite ao usuário:
   - O nome do Caso de Uso (ex: `RegistrarTreino`).
   - A qual dos 4 Bounded Contexts ele pertence (Identity, CRM, TrainingPlanning, Execution).
   - Se é um Comando (escrita/EF Core) ou uma Query (leitura/Dapper).
2. **Estrutura de Pastas:** Navegue até o Bounded Context escolhido e crie uma pasta exclusiva com o nome do Caso de Uso. É terminantemente proibido criar pastas chamadas "Services", "Repositories" ou "Controllers" para abrigar esses arquivos.
3. **Geração de Arquivos (Tudo na mesma pasta):**
   - Crie a classe do Request/Command (ex: `RegistrarTreinoCommand : IRequest<Result>`).
   - Crie o Handler (`RegistrarTreinoHandler : IRequestHandler`).
   - Crie a rota (Minimal API Endpoint) mapeando para este MediatR.
4. **Injeção de Resiliência e Logs:** O Handler deve obrigatoriamente conter uma chamada de log estruturado do Serilog (ex: `_logger.LogInformation("Iniciando {CasoDeUso} para o Tenant {TenantId}...")`).
5. **Eventos de Domínio:** Se for uma operação de escrita que afeta o domínio, inclua um comentário `// TODO: Disparar evento de domínio via IPublisher do MediatR`.
6. **Entrega:** Mostre a estrutura de arquivos gerada e forneça o código de cada arquivo.