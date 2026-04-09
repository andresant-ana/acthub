# Project State Document (PSD) - ActHub
**Última Atualização:** Quarta-feira, 8 de Abril de 2026

## 1. Topologia de Diretórios Atual
- `src/backend/`: Contém a Solution C# (.NET 8) e os 4 módulos físicos (Identity, CRM, TrainingPlanning, Execution).
- `src/frontend/`: Contém a fundação React PWA (Vite).
- `infra/terraform/`: Contém os artefatos de IaC (Resource Group, App Service Plan, PostgreSQL, Key Vault).
- `docs/adrs/`: Contém os registros de decisões arquiteturais do sistema.

## 2. Última Issue Concluída
- **Issue:** #11 - Criação dos ADRs Fundamentais
- **Resumo da Modificação:** Criação dos 4 primeiros Architecture Decision Records (ADRs) documentando o uso de Monolito Modular, Vertical Slice Architecture, MediatR e Terraform.

## 3. Estado da Infraestrutura / CI/CD
- **Infraestrutura:** Azure provisionado (brazilsouth). Banco PostgreSQL ativo. Key Vault configurado.
- **CI/CD:** Pendente (Issues #7, #8 e #9).

## 4. Trabalhos em Progresso (WIP)
- Nenhum. Aguardando planejamento da esteira de CI/CD.