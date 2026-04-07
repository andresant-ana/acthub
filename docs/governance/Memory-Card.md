# ActHub - Memory Card

Este documento é a memória persistente do projeto. Deve ser atualizado ao final de toda sessão estratégica relevante.

## 1. Decisões Arquiteturais Tomadas

- **Monolito Modular (Adotado):** A arquitetura base do sistema é um Monolito Modular, contrapondo-se à adoção prematura de Microsserviços. O código será executado em um único processo físico na memória, fatiado logicamente em fronteiras estritas.
  - **Trade-off / Por que:** Microsserviços resolvem problemas de escala organizacional, mas cobram um preço altíssimo em complexidade de infraestrutura, consistência eventual e latência de rede. Para o estágio de validação e tração inicial, o Monolito Modular entrega a coesão necessária com baixo custo operacional. A transição futura exigirá apenas o deslocamento físico de um módulo, sem reescrever regras de negócio.
  - **Descartado:** Microsserviços e adoção de orquestradores complexos para o estágio inicial.

- **Vertical Slice Architecture (Adotado):** O ActHub adota a Arquitetura de Fatias Verticais em oposição à Clean Architecture.
  - **Trade-off / Por que:** O pragmatismo dita que nem todo fluxo do sistema possui a mesma complexidade. Uma fatia vertical agrupa todo o código necessário para uma funcionalidade, da rota da API até a consulta no banco. Fluxos complexos, como registrar uma série e calcular o 1RM, atravessam um domínio rico, enquanto fluxos simples, como buscar perfil, ignoram objetos de domínio e realizam consultas diretas utilizando SQL puro.
  - **Descartado:** Clean Architecture tradicional (`Core`, `Application`, `Infrastructure`), proibida por gerar camadas e abstrações de processamento inúteis.

- **Comunicação Orientada a Eventos em Memória (Adotado):** A comunicação entre Contextos Delimitados é estritamente proibida via chamadas diretas de métodos ou injeção de serviços. Utiliza-se o padrão Publish/Subscribe nativo em memória RAM através do MediatR.
  - **Trade-off / Por que:** Garante o desacoplamento. Um contexto emite um evento, como `WorkoutSessionCompletedEvent`, e encerra seu trabalho, permitindo que outros módulos, como o CRM, atuem como subscribers de forma autônoma e silenciosa.

- **Design for Failure (Adotado):** O sistema é projetado sob a certeza matemática de que a infraestrutura vai falhar.
  - **Trade-off / Por que:** Implementação de Resiliência Transiente com Polly, utilizando Retry com Exponential Backoff e Circuit Breakers para proteger contra cascatas de erro em redes e bancos de dados. Utilização de Serilog para logs estruturados e indexáveis com rastreabilidade imediata. Configuração de Health Checks dinâmicos para reinicialização proativa pelo Azure.

- **Infraestrutura como Código - IaC (Adotado):** O provisionamento no Azure é feito estritamente via Terraform/Bicep, eliminando o “Muro da Confusão” e configurações manuais.

- **Contêineres e Orquestração (Adotado Localmente):** Docker é utilizado exclusivamente como ferramenta de apoio local para simular o PostgreSQL no WSL durante a construção do back-end.
  - **Descartado:** Kubernetes (K8s) e Azure Container Instances (ACI) em produção, devido à complexidade acidental e incompatibilidade com restrições orçamentárias (burn rate) do Free Trial.

## 2. Bounded Contexts — Estado Atual

A complexidade do negócio é dominada por quatro fronteiras estritas:

- **Identity & Access Context (Identidade e Acesso):**
  - **Definido:** Responsável pela autenticação via JWT, gestão de perfis de acesso e validação dos tiers de assinatura (Starter, Pro, Elite). Totalmente isolado das lógicas de treinamento. Implementado na Fase 2.
  - **Pendente:** Implementação C# e infraestrutura de banco de dados específica.

- **CRM & Engagement Context (Relacionamento B2B):**
  - **Definido:** Painel de controle do personal trainer B2B, gerenciando o vínculo com os alunos. Domínio puramente reativo: recebe sinais assíncronos do sistema para calcular o risco de evasão (Churn Risk) e gerar alertas preventivos.
  - **Pendente:** Modelagem matemática dos gatilhos que definem a evasão do aluno.

- **Training Planning Context (Prescrição e Periodização):**
  - **Definido:** O motor estático do software. Engloba o catálogo de exercícios focado em biomecânica básica e a estruturação relacional de Macrociclos e Microciclos, definindo o volume de treino alvo.
  - **Pendente:** Estrutura relacional exata das tabelas.

- **Execution & Analytics Context (Motor de Progressão):**
  - **Definido:** O “Core Domain” de maior estresse computacional. Processa o input diário de Carga, Repetições, RIR e RPE, aplicando fórmulas empíricas como a Fórmula de Epley para 1RM em Objetos de Valor encapsulados. Exige-se obrigatoriamente 100% de cobertura de testes unitários nesses cálculos.
  - **Pendente:** Tradução dos algoritmos matemáticos para métodos C#.

## 3. Stack e Tecnologias Confirmadas

- **Linguagem e Runtime Back-end:** C# (.NET 8+).
- **Front-end:** React PWA (Progressive Web App), garantindo fricção zero na adoção por envio de link via WhatsApp e adição à tela inicial, com suporte Offline-First através de Service Workers e IndexedDB.
- **Banco de Dados:** PostgreSQL Flexible Server (Relacional), espelhando as necessidades transacionais dos Bounded Contexts.
- **Acesso a Dados:** Entity Framework Core para operações complexas de domínio e Dapper para operações de leitura de altíssima performance.
- **Infraestrutura Cloud:** Microsoft Azure.
- **Infraestrutura como Código (IaC):** Terraform (HCL) com o provedor `azurerm`.
- **CI/CD:** GitHub Actions atuando no ciclo de vida da aplicação com validações estáticas (Shift-Left Quality) e deploy automatizado.
- **Mensageria Local:** MediatR.
- **Resiliência e Observabilidade:** Polly, Serilog e OpenTelemetry.

## 4. Diretrizes de Infraestrutura

- **Provedor Terraform:** Configurado com a trava de segurança `resource_provider_registrations = "none"` para evitar bloqueios de Rate Limit por tentativas de registro em massa de APIs não utilizadas na conta Azure.
- **Resource Group:** `rg-acthub-dev`.
- **App Service Plan:** `plan-acthub-dev`. Sistema Operacional cravado em Linux.
- **Pivôs de FinOps e Região:** Devido ao hard lock de cota da Microsoft para instâncias gratuitas nas regiões americanas (`eastus` e `eastus2`), a infraestrutura foi pivotada para a região `brazilsouth`. Com a mudança geográfica, o SKU foi mantido com sucesso em F1 (Free), garantindo a ausência de custos operacionais e preservando integralmente a verba promocional de desenvolvimento.
- **Segurança de Estado:** O arquivo `.tfstate` está estritamente ignorado via `.gitignore`, protegendo credenciais e IDs reais de vazamentos no repositório remoto.

## 5. Padrões e Convenções Definidas

- **FinOps Cognitivo (Divisão de IA):** A orquestração divide o peso cognitivo. O Antigravity atua como Arquiteto e Revisor, encarregado da estratégia e validação visual. O OpenCode atua como Executor via CLI, focado na sintaxe e restrito pelas regras locais.
- **Arquitetura de Nomenclatura Cloud:** Uso obrigatório de prefixos corporativos (`rg-acthub-`, `plan-acthub-`, `psql-acthub-`).
- **Separação de Módulos Terraform:** É expressamente proibido consolidar IaC no `main.tf`. Estrutura modular exigida: `main.tf`, `variables.tf`, `outputs.tf` e `providers.tf`.
- **Conceito Positivo:** A interface deve refletir uma estética “positiva e aspiracional” (`Ascend/Uplift concept`).
- **Regras de Código:** Nomes em Inglês. Comentários justificativos de negócio complexo em Português Brasileiro formal. Blocos `try/catch` vazios são inadmissíveis.

## 6. Backlog Arquitetural e Cronograma (Stateless)

O projeto segue um roadmap restrito em cinco fases estratégicas. O estado de conclusão das tarefas não é rastreado neste documento, mas sim gerenciado dinamicamente via GitHub Projects e sincronizado no início de cada sessão via chat (State Sync).

- **Fase 1: Fundação, Infraestrutura e Setup do Antigravity**
  - **Objetivo:** Nenhuma linha de código de negócio é escrita antes da infraestrutura e da esteira existirem.
  - **Issue #1:** Setup de ambiente Linux (WSL 2).
  - **Issue #2:** Configuração de Identidade e Criptografia (Git + SSH).
  - **Issue #3:** Estabelecer ADRs e Diretrizes de IA no Workspace.
  - **Issue #4:** IaC: Provisionar Resource Group e App Service Plan no Azure via Terraform.
  - **Issue #5:** IaC: Provisionar Banco de Dados PostgreSQL Flexible Server.
  - **Issue #6:** IaC: Configurar Azure Key Vault.
  - **Issue #10:** [Scaffolding] Estruturar Solution do C# (.NET 8) e esqueleto do React PWA.
  - **Issue #7:** CI/CD: Pipeline de Build (GitHub Actions).
  - **Issue #8:** CI/CD: Pipeline de Análise Estática (Shift-Left).
  - **Issue #9:** CI/CD: Pipeline de Deploy.

- **Fase 2: O Núcleo Matemático e Back-end Base**
  - Construção do Monolito Modular em .NET utilizando Vertical Slice Architecture.
  - **Lote de Issues a ser planejado arquiteturalmente pelo Tech Lead:** Implementação do Identity & Access Context, Execution & Analytics Context, Training Planning Context, e Mensageria Interna via MediatR.

- **Fase 3: Fricção Zero e Interface PWA**
  - **Lote de Issues a ser planejado arquiteturalmente pelo Tech Lead:** Fundação Offline-First no React com Service Workers e IndexedDB. Construção do WebApp B2C e do painel CRM B2B.

- **Fase 4: Resiliência, Observabilidade e Prontidão para Produção**
  - **Lote de Issues a ser planejado arquiteturalmente pelo Tech Lead:** Implementação de Design for Failure (Polly), Telemetria (Serilog/OpenTelemetry) e Health Checks no Azure.

- **Fase 5: Validação de Mercado (Go-To-Market) e Pós-Produção**
  - **Lote de ações comerciais:** Entrada do Paciente Zero, ativação de afiliados, prospecção física B2B e monitoramento ativo do feedback loop.

## 7. Estratégia de Negócios e Go-To-Market (GTM)

- **Posicionamento:** Primeiro CRM de musculação focado no “Motor de Progressão Inteligente”, automatizando RPE/RIR/1RM para transformar o treinador em estrategista de performance.
- **Distribuição B2C2B:** Foco em utilizar o aluno final (B2C) para criar pressão sobre o personal (B2B), utilizando gatilhos de Autoridade e Aprovação Social.
- **Paciente Zero:** Validação do método através do personal Sérgio Oliveira, cujos links parametrizados (UTM) alimentarão o sistema de rastreamento de aquisição.
- **Sistema de Afiliados e Monetização:** Baseado em Custo por Aquisição (CPA), oferecendo comissão agressiva na primeira mensalidade e participação menor recorrente sem ceder equity.
- **Pricing Tiers:**
  - **Starter (R$ 69/mês):** Até 10 alunos.
  - **Pro (R$ 149/mês):** Até 50 alunos. Core business e foco da prospecção física.
  - **Elite (R$ 299/mês):** Alunos ilimitados.
- **Vantagem Competitiva (Switching Cost):** A adoção é de fricção zero via navegador, eliminando lojas de aplicativos. A retenção a longo prazo é garantida pelo “Fosso de Dados”: o acúmulo histórico de evolução matemática e visual do aluno torna o custo de mudança de plataforma altíssimo para o personal.
- **KPIs Monitorados:** CAC, Taxa de Ativação em 24 horas e Churn Rate como reflexo da aderência do aluno final.

## 8. Referências Bibliográficas (Fundamentação Teórica)

A arquitetura e os modelos operacionais do ActHub são ancorados em preceitos bibliográficos comprovados:

- **Autorregulação e Biomecânica:** Baseado nos preceitos de treinamento de força da literatura de Eric Helms (`The Muscle and Strength Pyramids`).
- **Marketing e Conversão B2C2B:** Alavancagem de gatilhos mentais estruturados a partir dos ensinamentos de Robert Cialdini (`Influence`).
- **Engenharia de Preços:** Rentabilização desenhada pelo valor percebido da inovação, e não pelo custo de infraestrutura, embasado por Madhavan Ramanujam (`Monetizing Innovation`).
- **Iteração e KPIs de Mercado:** Validação empírica contínua fundamentada por Eric Ries (`The Lean Startup`).

## 9. Problemas Resolvidos (Cicatrizes de Engenharia)

- **Falha de Execução Node.js:** Contaminação do ambiente `/mnt/c/` no WSL. Solucionado através da instalação isolada do NVM e Node.js LTS nativos no Ubuntu.
- **Rate Limits de IA Gratuita:** Bloqueio de requisição do modelo `Qwen3-coder-480b` no OpenRouter. Solucionado removendo o hardcode do modelo no arquivo `.md` do subagente e transferindo o controle para a interface gráfica, adotando o Nemotron.
- **Time Out Terraform (Context Canceled):** O Azure entrou em loop infinito ao tentar registrar dezenas de APIs irrelevantes de forma autônoma. Solucionado injetando a flag `resource_provider_registrations = "none"`.
- **Bloqueio Global de Cota (Free VMs):** A Microsoft negou o provisionamento nas regiões norte-americanas para a assinatura de avaliação. Solucionado acionando pivô de infraestrutura, transferindo o datacenter para `brazilsouth` e consumindo créditos promocionais com a camada B1.
- **Higiene de Repositório:** Pastas residuais geradas indevidamente por gerenciadores de pacote (`node_modules`, `bun.lock`) foram limpas cirurgicamente para não comprometer a IaC.

## 10. Decisões Pendentes ou em Aberto

- **Model Context Protocol (MCP):** A integração profunda do MCP (FileSystem, GitHub, PostgreSQL) para automação de agentes foi teorizada e considerada válida a longo prazo, mas deliberadamente adiada para a Fase 3 e posteriores. No cenário atual, a remoção da revisão humana é considerada um risco de engenharia incompatível com o isolamento em nuvem.

- **Containerização do Banco Local:** A topologia do arquivo `docker-compose.yml` para a simulação do PostgreSQL e isolamento do motor no ambiente de desenvolvimento WSL será escrita futuramente.

- **Agente de Qualidade:** O subagente do OpenCode destinado a atuar primariamente como `@tester` ainda requer a criação de seu arquivo `.md` de diretrizes.

- **Conflito Matemático de FinOps (Créditos Azure vs. Cronograma GTM):** O planejamento estratégico prevê o início da Validação de Mercado (Fase 5) a partir da Semana 10. Contudo, os US$ 200 de crédito da assinatura Free Trial expiram na Semana 4 (30 dias). Isso cria um “Vale da Morte” financeiro operacional. O avanço do sistema exigirá a mesma consistência rigorosa e resiliência de longo prazo já aplicada em treinamentos físicos de alta intensidade para que a engenharia não estagne com o fim do subsídio da Microsoft.
  - **Ação Pendente:** Definir previamente se os recursos, como o banco de dados, serão rebaixados no mês 2, ou se haverá alocação de orçamento pessoal contido para sustentar a performance até a conversão das primeiras comissões de afiliados.

- **Ponto Único de Falha na Infraestrutura (Terraform State):** A exclusão do arquivo `terraform.tfstate` via `.gitignore` foi vital para a segurança criptográfica, mas isolou o mapeamento real da nuvem em um único arquivo local no ambiente WSL 2. Se houver corrupção no disco virtual do host, o controle declarativo da infraestrutura será irremediavelmente perdido.
  - **Ação Pendente:** Programar para a Fase 2 ou 3 a migração do estado local para um Remote State em Azure Blob Storage criptografado, transferindo a responsabilidade da guarda do arquivo para o datacenter e garantindo redundância arquitetural.

## 11. Regras Invioláveis Definidas (Governança)

- **Single Source of Truth:** O repositório obedece a uma única fonte de verdade arquitetural baseada no documento `ARCHITECTURE.md` alocado na raiz. O agente do OpenCode possui ordem expressa de leitura deste documento antes de qualquer alteração estrutural.

- **Segurança Criptográfica e Zero Hardcode:** Sob nenhuma hipótese os artefatos `.tf` conterão credenciais de banco de dados e segredos expostos. Variáveis de acesso exigem obrigatoriamente a flag `sensitive = true`.

- **Definition of Done Rigoroso (IaC):** O status de uma tarefa de infraestrutura só avança para concluído após validação visual da alocação do recurso no próprio Portal do Azure, rejeitando aprovações baseadas unicamente no terminal log.

- **Identidade e Tom do Assistente:** Como Tech Lead, minha obrigação é não ceder à validação vazia ou ao excesso de conformidade. Exijo a aplicação rigorosa do senso crítico perante alucinações técnicas, comunico-me com precisão em Português Brasileiro, elaborando argumentações formais detalhadas em tópicos complexos, sendo absolutamente isento do uso de emojis.

- **Protocolo de Acionamento e Governança Operacional:** Para evitar alucinações e perda de escopo durante a delegação de tarefas para a IA de terminal (OpenCode), fica estabelecido o Acordo de Governança Operacional. Antes de qualquer prompt executivo, o Tech Lead deve fornecer o seguinte cabeçalho de contexto:
  - **Fase:** Ex.: Execução de IaC
  - **Ferramenta Alvo:** Ex.: OpenCode
  - **Subagente:** Ex.: `@implementer`
  - **Skill Necessária:** Ex.: `terraform-azure`
  - **Restrição de Conhecimento Externo:** A utilização de Skills comunitárias ou baixadas da internet é estritamente proibida. Todas as Skills, como Terraform, Autenticação e Error-Handling, serão desenvolvidas internamente, sob demanda, aplicando o princípio YAGNI (`You Aren't Gonna Need It`) para evitar contaminação do escopo com padrões alheios ao projeto.

- **Detalhamento Técnico das Issues em Andamento: Issue #5 — [IaC] Provisionar Banco de Dados PostgreSQL Flexible Server**
  - **Motor e Versão:** PostgreSQL versão 16, ou a mais recente suportada estavelmente pelo provedor Azure.
  - **SKU e Custo:** `B_Standard_B1ms` (Tier Burstable de menor custo para homologação e desenvolvimento).
  - **Storage Inicial:** 32 GB (tamanho mínimo exigido pelo provedor Azure).
  - **Topologia de Segurança e Rede:** Configuração mandatória do recurso `azurerm_postgresql_flexible_server_firewall_rule` com `start_ip_address` e `end_ip_address` definidos como `0.0.0.0` para garantir a comunicação fluida entre recursos internos do próprio Azure, como App Service acessando o banco de dados.
  - **Governança de Segredos:** Variáveis de administrador (`db_admin_user` e `db_admin_password`) instanciadas no `variables.tf` sempre com a diretriz `sensitive = true`.

## 12. Contexto Pessoal do Desenvolvedor

- **Identidade e Perspectiva:** André Sant’Ana Boim, 27 anos, desenvolvedor habituado à capital paulista. Profissional em transição para desafios sêniores através de um domínio arquitetural agudo. Possui visão estratégica para diagnóstico de problemas. Busca a construção de um portfólio robusto (`masterpiece`), priorizando engenharia de alto padrão.

- **Filosofia e Disciplina:** Aplica extrema disciplina mental derivada do comprometimento prolongado e sistemático com esportes de intensidade, especialmente musculação, transferindo essa ética para o estudo técnico. Prefere a diplomacia e a mitigação proativa de atritos interpessoais. Possui rotinas fixadas em hobbies de longo prazo, como esportes de acompanhamento tático e competições simuladas em Efootball. Estrutura ancorada em um relacionamento de suporte mútuo e longa data com Stephanie, centralizando o controle e a estabilidade essenciais para a alta performance na resolução de sistemas complexos.

- **Setup e Ambiente de Execução:** Opera com máquina host Windows e desenvolvimento puramente virtualizado no WSL 2 Ubuntu Linux. Centraliza os esforços no caminho absoluto `~/projects/acthub`. Mantém preferência explícita por controle visual, aliando o poder do bash à gestão transparente das IDEs visuais através do Antigravity e da interface do OpenCode.

## 13. Atualização de Estado — Preparação da Issue #10

### Resumo
Foi concluída a preparação operacional e cognitiva para iniciar com segurança a Issue #10, cujo escopo permanece restrito ao scaffolding estrutural da Solution em C# (.NET 8) e do esqueleto React PWA, sem implementação de regra de negócio.

### Governança Cognitiva Consolidada
- Foi consolidada a dupla documental local de governança:
  - `ARCHITECTURE.md` como fonte arquitetural soberana na raiz do repositório.
  - `AGENTS.md` como carga operacional curta e permanente para agentes.
- Foram criados os gates formais do OpenCode:
  - `.opencode/commands/plan.md`
  - `.opencode/commands/review.md`
- O subagente `@implementer` foi recalibrado para:
  - uso obrigatório de skill por escopo;
  - bloqueio explícito de horizontalização;
  - proibição de improvisar arquitetura;
  - execução restrita ao plano aprovado.
- Foi criado o subagente `@reviewer` para auditoria fria com contexto isolado.
- Foram criadas apenas as duas skills mínimas necessárias ao estágio atual:
  - `dotnet-solution-scaffolding`
  - `react-pwa-foundation`
- A rule exclusiva do Antigravity foi recalibrada para respeitar o escopo de scaffolding estrutural, sem antecipar implementação funcional.
- Foi criado o workflow:
  - `.agents/workflows/planejar-scaffolding-issue10.md`
- Os workflows abaixo foram mantidos, porém estão explicitamente fora de uso para a Issue #10:
  - `criar-fatia-vertical`
  - `gerar-iac-azure`

### Segurança Operacional
- A credencial administrativa do PostgreSQL Flexible Server foi rotacionada após exposição operacional indevida em contexto de chat.
- O segredo correspondente foi atualizado no Azure Key Vault.
- O valor operacional local foi sincronizado no ambiente de desenvolvimento.
- Fica reforçado que o uso de Key Vault não elimina a sensibilidade do estado local do Terraform quando segredos são geridos por recursos declarativos.

### Ambiente Local Validado
- Diretório de execução confirmado: `~/projects/acthub`
- Runtime e SDK validados no WSL 2 Ubuntu Linux:
  - `.NET SDK 8.0.125`
  - `Node.js v24.14.1`
  - `npm 11.11.0`
  - `git 2.43.0`
- O ambiente está apto para iniciar o scaffolding da Issue #10.
- O projeto permanece centralizado em `~/projects/acthub`, com desenvolvimento integral no WSL.

### Estado Atual do Projeto
- A preparação específica para a Issue #10 foi concluída.
- A Issue #10 permanece em `In Progress` no GitHub Projects.
- Nenhum artefato funcional de aplicação foi gerado nesta etapa.
- O workflow correto permanece:
  1. planejamento estrutural;
  2. validação humana;
  3. execução controlada;
  4. revisão fria;
  5. aprovação humana final.
- A Fase 1 ainda mantém pendência dos pipelines de CI/CD:
  - Issue #7
  - Issue #8
  - Issue #9

### Regras Operacionais Reforçadas para a Issue #10
- A Issue #10 deve ser tratada como scaffolding estrutural puro.
- É proibido nesta issue:
  - criar handlers;
  - criar endpoints;
  - implementar autenticação;
  - implementar domínio rico;
  - configurar persistência real;
  - configurar MediatR funcional;
  - configurar Polly, Serilog, OpenTelemetry ou Health Checks;
  - implementar telas reais de produto;
  - aplicar Clean Architecture tradicional;
  - criar estruturas horizontais como `Controllers`, `Services`, `Repositories`, `Core`, `Application` ou `Infrastructure`.
- Nenhuma IA possui permissão de autoaprovação.
- O OpenCode só pode executar após plano aprovado pelo humano.
- O Antigravity, neste estágio, atua como camada de planejamento estrutural e validação, não como executor físico principal.

### Pendências Imediatas
- Executar o planejamento estrutural da Issue #10 no Antigravity.
- Submeter o resultado ao gate `/plan` no OpenCode.
- Executar o scaffolding físico apenas após luz verde humana explícita.
- Revisar o diff gerado através do `/review` com o `@reviewer`.