# 0004 - Infraestrutura e Cultura DevOps com Terraform (Azure)

## Status
Accepted

## Context
Historicamente, infraestruturas criadas manualmente através de portais da nuvem (ClickOps) resultam em ambientes impossíveis de auditar, difíceis de reproduzir (drift de configuração entre Staging e Production) e dependentes de "heróis operacionais". O ActHub precisa de estabilidade, escalabilidade rápida e um processo livre do "Muro da Confusão" (onde Devs jogam o código por cima do muro para Ops implantar), garantindo os princípios ágeis de entrega contínua.

## Decision
Adotamos a **Infraestrutura como Código (IaC) via Terraform** para provisionar 100% dos recursos no provedor principal Microsoft Azure. Os scripts em HCL (HashiCorp Configuration Language) são cidadãos de primeira classe do repositório, garantindo que a infraestrutura, banco de dados (PostgreSQL Flexible Server), e App Services acompanhem rigorosamente as versões de código do sistema.

## Consequences
- **Positivas:** 
    - Previsibilidade absoluta. O plano de execução do Terraform garante o que vai ser alterado antes de qualquer mudança em nuvem, garantindo auditoria de configurações e segurança.
    - Rastreabilidade via Git (o repositório de código serve de inventário confiável do servidor).
    - Cultura *Shift-Left*: Infraestrutura não é um gargalo de fim de processo; os desenvolvedores definem o ambiente paralelamente à arquitetura da aplicação e o pipeline automatiza a entrega (CI/CD).
- **Negativas:** 
    - Adiciona uma curva técnica e sintática significativa (HCL, Azure Providers) ao time de desenvolvedores C#.
    - Gerenciar o estado (*state file*) do Terraform com segurança para não expor segredos e chaves de acesso passa a ser uma preocupação crítica.
