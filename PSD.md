# Project State Document (PSD) - ActHub (Versão 3.0)
Data de Atualização: 08/04/2026

## 1. Identidade do Projeto e Negócio
O ActHub é um SaaS B2B2C voltado à gestão, periodização de treinos e acompanhamento biomecânico para personal trainers e seus alunos. O domínio principal foi particionado nos seguintes Bounded Contexts (módulos físicos):
- **`Identity`**: Gestão de acesso, perfis, autenticação e autorização dos usuários.
- **`CRM`**: Engajamento, onboarding de alunos e relacionamento Personal-Aluno.
- **`TrainingPlanning`**: Planejamento e montagem estrutural das sessões e programas de treinos.
- **`Execution`**: Analytics de desempenho, cálculos biomecânicos avançados, progressão de carga (1RM) e acompanhamento em tempo real da execução dos treinos.

## 2. Estado Arquitetural e Toolchain
O sistema adota estritamente os princípios de **Monolito Modular** e **Vertical Slice Architecture**.
- **Backend:** Desenvolvido em **.NET 8** (SDK 8.0.125). A comunicação inter-módulos ocorrerá exclusivamente via **MediatR** (mensageria em memória), garantindo o baixo acoplamento.
- **Frontend:** Desenvolvido como um **React PWA** (Vite, TypeScript, rodando no Node.js v24.14.1), estabelecendo a fundação estrutural SPA/PWA inicial.
- **Atenção:** **Até o presente momento, nenhuma lógica de domínio, endpoint de API ou persistência (EF Core/Dapper) foi implementada. O projeto encontra-se em fase de scaffolding estrutural.**

## 3. Estado da Infraestrutura (Azure & Terraform)
A infraestrutura em nuvem foi declarada via Terraform e alocada na região `brazilsouth`:
- **Computação:** Resource Group e App Service Plan (OS Linux) provisionados.
- **Banco de Dados:** Servidor PostgreSQL Flexible Server (v16, SKU `B_Standard_B1ms`).
- **Segurança e Segredos:** Azure Key Vault provisionado. A senha do banco de dados foi recentemente rotacionada após um vazamento acidental. O estado local do repositório foi devidamente higienizado, e as exclusões de artefatos sensíveis do Terraform (`.tfstate`, `.tfvars`) estão ativas e validadas no `.gitignore`.

## 4. Governança, Topologia e ADRs
**Topologia Física Atual:**
- `src/backend/`: Contém a Solution C# (`ActHub.sln`) e os 5 projetos iniciais (`ActHub.Api` host, `ActHub.Modules.CRM`, `ActHub.Modules.Execution`, `ActHub.Modules.Identity`, `ActHub.Modules.TrainingPlanning`).
- `src/frontend/`: Contém a fundação do React PWA.
- `infra/terraform/`: Contém os scripts Terraform (`main.tf`, `outputs.tf`, `providers.tf`, `variables.tf`).
- `docs/adrs/`: Contém os registros de decisões arquiteturais.

**Architecture Decision Records (ADRs) Aprovados:**
- **0001:** Monolito Modular (`0001-monolito-modular.md`)
- **0002:** Vertical Slice Architecture (`0002-vertical-slice-architecture.md`)
- **0003:** Mensageria em Memória via MediatR (`0003-mensageria-em-memoria-mediatr.md`)
- **0004:** Infraestrutura em Nuvem Azure com Terraform (`0004-infraestrutura-nuvem-azure-terraform.md`)

## 5. Ecossistema de Agentes (Toolchain Local)
**Workflows Disponíveis:**
- `/propose`: Elabora plano tático e aplica parada obrigatória (Pause-and-Wait) antes de qualquer alteração física.
- `/implement`: Executa o plano físico rigorosamente.
- `/review`: Auditor técnico de código gerado.

**Skills Disponíveis:**
- `dotnet-solution-scaffolding`
- `react-pwa-foundation`
- `terraform-azure`

## 6. Trabalhos em Progresso (WIP) e Decisão Tática
- **Prioridade Atual:** Aguardando início da Issue #7 (Pipeline de Build CI/CD via GitHub Actions).
- **Decisão Tática (CI/CD):** Os pipelines do GitHub Actions adotarão o modelo de Isolamento por Path (um arquivo `.yml` para o C# e outro para o React) visando otimização de FinOps e prevenção de recompilações desnecessárias, acionando builds específicos de acordo com a área do repositório modificada.