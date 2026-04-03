---
name: terraform-azure
description: >
  Use OBRIGATORIAMENTE quando a tarefa envolver a criação, modificação ou 
  leitura de scripts de Infraestrutura como Código (IaC) utilizando Terraform para a nuvem Microsoft Azure.
---

# Padrão de Infraestrutura Cloud (Azure + Terraform)

## Provedor e Configuração Base
- O provedor exclusivo é o `hashicorp/azurerm`.
- Sempre inclua o bloco `features {}` dentro do provider `azurerm`, é obrigatório na sintaxe atual.

## Regras Arquiteturais Invioláveis
1. **Separação de Arquivos:** Nunca coloque toda a infraestrutura no `main.tf`. Separe no mínimo em:
   - `main.tf` (chamada dos recursos principais)
   - `variables.tf` (declaração de variáveis de entrada)
   - `outputs.tf` (retorno de IDs e nomes gerados)
   - `providers.tf` (configuração do azurerm)
2. **Paridade de SO:** Todo `azurerm_service_plan` provisionado deve conter EXPLICITAMENTE `os_type = "Linux"`.
3. **Segurança (Zero Trust):** É TERMINANTEMENTE PROIBIDO realizar hardcode de credenciais, senhas ou tokens de acesso em arquivos `.tf`. Utilize sempre variáveis marcadas com `sensitive = true`.

## Nomenclatura Padrão (Prefixos Corporativos)
- Resource Group: `rg-acthub-<ambiente>`
- App Service Plan: `plan-acthub-<ambiente>`
- App Service (Web App): `app-acthub-<ambiente>`
- PostgreSQL Flexible Server: `psql-acthub-<ambiente>`
