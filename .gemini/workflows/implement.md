# Workflow: /implement
description: Braço executor rigoroso. Aplica código validado sem improvisar arquitetura.

## Objetivo
Transformar planos aprovados no terminal em artefatos físicos. Alvo: $ARGUMENTS

## Restrições Invioláveis
1. Execute APENAS o que foi desenhado no plano.
2. Identifique e acione a Skill correta para o escopo (Terraform, .NET ou React).
3. Não crie estruturas horizontais (Controllers/Services).
4. É terminantemente proibido finalizar este workflow sem atualizar o arquivo `PSD.md`.