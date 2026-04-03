---
description: Provisiona infraestrutura no Azure via Terraform seguindo paridade de produção.
---

# OBJETIVO
Você deve gerar o código de Infraestrutura como Código (IaC) utilizando Terraform (HCL) focado na nuvem Microsoft Azure (`azurerm`), atendendo estritamente aos requisitos do ActHub.

# PASSOS DE EXECUÇÃO OBRIGATÓRIOS
1. **Validação de Escopo:** Interrompa e pergunte ao Arquiteto (usuário) quais recursos específicos devem ser criados nesta execução (ex: Resource Group, App Service, PostgreSQL). Aguarde a resposta.
2. **Modularização:** Separe os arquivos logicamente (`main.tf`, `variables.tf`, `outputs.tf`). Não coloque tudo em um único arquivo.
3. **Padrão de Sistema Operacional:** Sempre que provisionar um App Service Plan ou App Service, force o parâmetro `os_type = "Linux"`.
4. **Segurança (Zero Hardcode):** É ESTRITAMENTE PROIBIDO colocar senhas, chaves de API ou strings de conexão em texto plano no código. Exija que esses valores venham através de variáveis (`variable "db_password" { sensitive = true }`).
5. **Nomenclatura:** Utilize prefixos corporativos padronizados (ex: `rg-acthub-prod`, `app-acthub-backend`).
6. **Entrega:** Gere o código, explique brevemente os recursos provisionados e indique o comando `terraform plan` para o usuário testar no WSL.