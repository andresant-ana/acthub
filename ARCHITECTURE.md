# Documentação de Arquitetura e Engenharia de Software

## 1. Visão Geral e Governança Técnica

O ActHub é um sistema SaaS de gestão e periodização de treinos voltado para personal trainers (B2B2C). A engenharia por trás deste projeto rejeita a complexidade acidental e adota uma postura pragmática orientada a valor de negócio. O sistema é desenhado para suportar o rigor da biomecânica através de um Modelo de Domínio Rico (Rich Domain Model) e é sustentado por uma cultura DevOps nativa desde sua concepção.

### 1.1. Architecture Decision Records (ADRs)

Para evidenciar o raciocínio arquitetural, o repositório mantém um registro histórico das decisões (ADRs). O objetivo não é apenas documentar *o que* foi feito, mas *por que* foi feito, detalhando os trade-offs avaliados. Decisões como a escolha do banco relacional em detrimento do NoSQL, ou a adoção de Vertical Slices em vez de Clean Architecture tradicional, estão formalmente justificadas nestes documentos.

### 1.2. Cultura DevOps e Infraestrutura como Código (IaC)

O projeto elimina o "Muro da Confusão" entre desenvolvimento e operações. A infraestrutura no Microsoft Azure (App Services, PostgreSQL Flexible Server) é provisionada e versionada através de código (Terraform/Bicep). O ciclo de vida da aplicação é regido por pipelines de CI/CD via GitHub Actions, garantindo que nenhum código chegue a produção sem passar por validações estáticas e testes automatizados (Shift-Left).

## 2. Decisão do Padrão Macro: Monolito Modular

A arquitetura base é um **Monolito Modular**, contrapondo-se à adoção prematura de Microsserviços.

- **O Racional (Trade-off):** Microsserviços resolvem problemas de escala organizacional e tráfego massivo, mas cobram um preço altíssimo em complexidade de infraestrutura, consistência eventual e latência de rede. Para o estágio de validação e tração inicial do ActHub, um Monolito Modular entrega a coesão necessária com baixo custo operacional.
- **Preparação para Escala:** O sistema é blindado contra o acoplamento espaguete. O código roda em um único processo físico, mas é fatiado logicamente em fronteiras estritas. A transição futura para microsserviços exigirá apenas o deslocamento físico de um módulo, sem a necessidade de reescrever as regras de negócio.

## 3. Padrão Arquitetural Interno: Vertical Slice Architecture

Em oposição à Clean Architecture, que organiza o código em camadas horizontais rigorosas (Core, Application, Infrastructure), o ActHub adota a **Vertical Slice Architecture** (Arquitetura de Fatias Verticais).

- **O Racional (Trade-off):** O pragmatismo dita que nem todo fluxo do sistema possui a mesma complexidade. Uma fatia vertical agrupa todo o código necessário para uma única funcionalidade (Caso de Uso), da rota da API até a consulta no banco de dados.
- **Execução:** Um fluxo complexo, como registrar uma série de treino e calcular o 1RM, atravessa um domínio rico, validações matemáticas e injeções de dependência. Um fluxo simples, como buscar os dados de perfil do personal, ignora os objetos de domínio e realiza uma consulta direta e performática utilizando SQL puro, evitando abstrações que apenas consomem processamento atoa.

## 4. Mapeamento de Contextos Delimitados (Bounded Contexts)

A complexidade do negócio é dominada pela separação de responsabilidades nas seguintes fronteiras:

1. **Identity & Access Context (Identidade e Acesso):**
    - *Responsabilidade:* Autenticação (JWT), gestão de perfis de acesso, e validação de tiers de assinatura (Starter, Pro, Elite). Este contexto é isolado das lógicas de treinamento.
2. **CRM & Engagement Context (Relacionamento B2B):**
    - *Responsabilidade:* Painel de controle do personal trainer. Gerencia o vínculo entre profissionais e alunos. Este domínio é reativo: ele recebe sinais do sistema sobre o desempenho do aluno e calcula o risco de evasão (Churn Risk), gerando alertas preventivos.
3. **Training Planning Context (Prescrição e Periodização):**
    - *Responsabilidade:* O motor estático do software. Engloba o catálogo de exercícios (actina/miosina, biomecânica básica) e a estruturação de Macrociclos e Microciclos. Define o volume de treino alvo projetado pelo treinador.
4. **Execution & Analytics Context (Motor de Progressão):**
    - *Responsabilidade:* O "Core Domain" de maior estresse computacional. Processa o *input* diário (Carga, Repetições, RIR, RPE), aplica fórmulas empíricas (Fórmula de Epley para 1RM) em Objetos de Valor encapsulados e projeta a curva de ganho de força.

## 5. Modelagem de Domínio e Desacoplamento via Mensageria

A comunicação entre os Contextos Delimitados é estritamente proibida através de chamadas diretas de métodos ou injeção de serviços de outros módulos, garantindo o baixo acoplamento.

- **Eventos de Domínio em Memória (MediatR):** A comunicação inter-módulos utiliza o padrão *Publish/Subscribe* nativo em memória RAM através da biblioteca MediatR.
- **Exemplo Prático:** Quando o aluno finaliza o treino, o *Execution Context* calcula a carga, persiste os dados e emite um `WorkoutSessionCompletedEvent`. O módulo de Execução encerra seu trabalho sem conhecer o resto do sistema. Em background, o *CRM Context* atua como um *Subscriber*, capturando esse evento para recalcular o risco de churn de forma autônoma e silenciosa.

## 6. Design for Failure e Observabilidade (A Filosofia de Produção)

O ActHub foi projetado sob a certeza matemática de que a infraestrutura vai falhar em algum momento.

- **Resiliência Transiente (Polly):** Todas as integrações com banco de dados e APIs externas são envelopadas por políticas do Polly. Falhas de rede disparam tentativas automáticas (Retry com Exponential Backoff) e Circuit Breakers para proteger a aplicação de cascatas de erro.
- **Logs Estruturados (Serilog):** O sistema não emite textos genéricos, mas sim objetos de log indexáveis. Toda falha possui rastreabilidade imediata contendo o TenantId (Personal), StudentId e Contexto da Transação.
- **Health Checks Dinâmicos:** Endpoints dedicados (`/health`) validam continuamente a integridade do banco de dados e do pool de conexões, permitindo que a nuvem (Azure) reinicie a aplicação proativamente antes que o usuário final perceba a degradação do serviço.