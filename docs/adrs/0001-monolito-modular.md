# 0001 - Monolito Modular

## Status
Accepted

## Context
O ActHub encontra-se em sua fase inicial de validação de mercado (B2B2C) e construção de produto (MVP até a tração inicial). Embora microsserviços ofereçam independência técnica e de deploy, eles inserem um nível extremo de complexidade acidental (gerenciamento de rede, consistência eventual, latência intra-serviços, monitoramento distribuído). Para o cenário atual, as equipes precisam focar em entregar valor de negócio e validar hipóteses rapidamente. O sistema deve possuir alta coesão estrutural e estar preparado para, quando (e se) necessário, ser desmembrado com o mínimo de atrito.

## Decision
Adotamos a arquitetura de **Monolito Modular** como padrão macro de software. O sistema será compilado e implantado como um único processo físico (processo único de aplicação), mas seu código fonte e organização interna serão rigorosamente segregados em módulos independentes (Bounded Contexts) delimitados por lógicas de negócio.

## Consequences
- **Positivas:** 
    - Baixo custo e complexidade de deploy (um único App Service/Container).
    - Refatorações e transações de banco de dados inter-módulos (se estritamente necessárias, embora desencorajadas) são simplificadas pela execução na mesma memória.
    - O código é mantido coeso e livre da "latência de rede" típica de chamadas HTTP gRPC entre microsserviços.
- **Negativas:** 
    - Um erro crítico (Memory Leak, Stack Overflow) em um módulo isolado tem o poder de derrubar a aplicação inteira (processo host compartilhado).
    - O acoplamento espaguete é um risco constante; a disciplina da equipe em não violar o isolamento das fronteiras lógicas (evitando usar classes de infraestrutura de outro módulo) deve ser mantida com rigidez (possivelmente reforçada via ferramentas de validação de dependências como o ArchUnit ou NetArchTest).
