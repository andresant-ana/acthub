# PROJECT_CONTEXT — ActHub

## Status

```text
Projeto: ActHub
Tipo: SaaS B2B2C
Domínio: gestão, periodização e acompanhamento de treinos
Público primário: personal trainers
Público secundário: alunos/clientes dos personal trainers
Stack principal: .NET 8, React PWA, PostgreSQL, Azure, Terraform
Maturidade atual: scaffolding estrutural concluído; domínio funcional ainda não implementado
```

---

## Finalidade

O ActHub é um SaaS B2B2C voltado para personal trainers que precisam gerir alunos, prescrever treinos, acompanhar execução, analisar progressão e reduzir churn por meio de dados de performance.

A tese do produto é transformar o personal trainer em um gestor técnico de performance, reduzindo trabalho manual e aumentando retenção por meio de acompanhamento estruturado de treino, histórico de evolução e alertas acionáveis.

---

## Proposta de valor

O ActHub busca entregar:

- gestão de alunos para personal trainers;
- prescrição e periodização de treinos;
- acompanhamento de execução;
- análise de progressão de carga;
- cálculo de métricas de performance;
- apoio à retenção de alunos;
- experiência PWA com baixa fricção de adoção;
- base técnica sólida para evolução incremental.

---

## Modelo de negócio

O modelo é B2B2C:

```text
personal trainer → cliente pagante
aluno → usuário operacional/beneficiário da experiência
```

A estratégia comercial considera que a adoção pelo aluno pode gerar pressão positiva sobre o personal, desde que a experiência seja simples, rápida e útil.

---

## Produto em uma frase

```text
Um CRM e motor de progressão de treino para personal trainers, combinando gestão B2B, experiência PWA para alunos e análise técnica de evolução de performance.
```

---

## Domínio principal

O domínio do ActHub combina:

- gestão de relacionamento personal-aluno;
- prescrição de treino;
- periodização;
- execução de sessões;
- métricas de carga, repetições, RIR, RPE e 1RM;
- análise de progresso;
- sinais de engajamento e risco de evasão.

O domínio técnico mais importante é o acompanhamento de execução e progressão, especialmente onde cálculos, consistência e histórico afetam a qualidade percebida do produto.

---

## Bounded Contexts

### Identity & Access

Responsável por:

- autenticação;
- autorização;
- perfis de usuário;
- tiers de assinatura;
- controle de acesso entre personal, aluno e recursos.

Risco:

```text
alto
```

Mudanças aqui devem ser tratadas como sensíveis, frequentemente R3.

---

### CRM & Engagement

Responsável por:

- relacionamento entre personal e alunos;
- painel do personal;
- onboarding;
- sinais de engajamento;
- risco de churn;
- alertas preventivos.

Este contexto consome sinais do sistema, mas não deve se acoplar diretamente aos módulos de execução e planejamento.

---

### Training Planning

Responsável por:

- catálogo de exercícios;
- prescrição de treinos;
- periodização;
- macrociclos;
- microciclos;
- estrutura planejada de volume e intensidade.

É o motor estático de planejamento.

---

### Execution & Analytics

Responsável por:

- registro da execução real do treino;
- carga;
- repetições;
- RIR;
- RPE;
- cálculo de 1RM;
- análise de progressão;
- curva de evolução.

Este é o Core Domain técnico mais sensível, especialmente em cálculos e consistência histórica.

---

## Arquitetura pretendida

A arquitetura base é:

```text
Monólito Modular
Vertical Slice Architecture
Bounded Contexts isolados
Comunicação inter-módulos via eventos em memória
PostgreSQL relacional
Azure como ambiente cloud
Terraform para IaC
```

O ActHub rejeita microsserviços prematuros, horizontalização artificial e camadas genéricas sem dor real.

---

## Decisões arquiteturais já assumidas

- Monólito Modular como padrão macro inicial.
- Vertical Slice Architecture como padrão interno.
- Evitar Clean Architecture horizontal tradicional como default.
- Bounded Contexts isolados.
- MediatR para comunicação em memória entre módulos.
- PostgreSQL como banco relacional.
- Azure como cloud provider.
- Terraform para infraestrutura.
- React PWA como frontend.
- Observabilidade e resiliência como preocupações futuras planejadas, não como cerimônia inicial obrigatória em cada fatia.

---

## Estado atual do projeto

O projeto está em estágio de scaffolding estrutural.

Já existe:

- solution .NET em `src/backend/`;
- host `ActHub.Api`;
- módulos iniciais:
  - `ActHub.Modules.Identity`;
  - `ActHub.Modules.CRM`;
  - `ActHub.Modules.TrainingPlanning`;
  - `ActHub.Modules.Execution`;
- frontend React PWA em `src/frontend/`;
- infraestrutura Terraform em `infra/terraform/`;
- ADRs iniciais em `docs/adrs/`;
- pipeline backend inicial em GitHub Actions.

Ainda não existe, segundo o estado migrado:

- lógica real de domínio;
- endpoints funcionais de negócio;
- persistência EF Core/Dapper aplicada ao domínio;
- autenticação funcional;
- autorização funcional;
- mensageria funcional;
- observabilidade funcional;
- health checks funcionais;
- Polly/Serilog/OpenTelemetry aplicados.

---

## Objetivo técnico de curto prazo

Consolidar a fundação operacional antes de avançar em domínio funcional.

Prioridades prováveis:

1. completar pipelines de qualidade;
2. validar estrutura local de comandos;
3. estabilizar documentação de workspace;
4. preparar primeira task piloto com harness;
5. só então iniciar fatias funcionais pequenas.

---

## Restrições importantes

- Não introduzir microserviços sem dor real.
- Não criar camadas horizontais genéricas por padrão.
- Não criar abstrações antes de uso concreto.
- Não adicionar dependência por conveniência do agente.
- Não tocar produção ou segredo sem autorização explícita.
- Não tratar `PROJECT_STATE.md` como changelog.
- Não implementar auth/autorização como task simples.
- Não alterar Terraform real sem plano e validação.
- Não confiar em board como verdade técnica.
- Não permitir executor decidir arquitetura sozinho.

---

## Princípio de engenharia

```text
Complexidade precisa pagar aluguel.
```

O ActHub deve parecer maduro pela qualidade das decisões, não pela quantidade de ferramentas, camadas ou padrões.

---

## Relação com o harness

Este workspace deve seguir o harness global.

O Core Architect estrutura decisões, planos e prompts.

O OpenCode executa apenas dentro de escopo, risco, validação e artifact esperado.

A verdade local do ActHub está nos documentos deste workspace, no código, nos ADRs e no estado técnico registrado.