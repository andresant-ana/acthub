# GTM_STRATEGY — ActHub

## Finalidade

Este documento registra a estratégia de produto, posicionamento e Go-To-Market do ActHub.

Ele deve orientar decisões de produto, priorização e experiência, mas não deve substituir documentação técnica, ADRs, estado operacional ou critérios de segurança.

---

## Tese do produto

O ActHub é um SaaS B2B2C para personal trainers que combina gestão de alunos, prescrição de treino e acompanhamento de progressão.

A proposta central é transformar o personal trainer em um gestor técnico de performance, usando dados de execução para aumentar retenção, reduzir trabalho manual e melhorar percepção de valor.

---

## Posicionamento

```text
CRM de musculação e motor de progressão inteligente para personal trainers.
```

O ActHub não deve ser apenas uma agenda, ficha digital ou app genérico de treino.

Ele deve se diferenciar por:

- acompanhamento de progressão;
- histórico de performance;
- métricas úteis;
- relação personal-aluno;
- fricção baixa de adoção;
- experiência PWA;
- retenção baseada em dados.

---

## Cliente primário

```text
Personal trainer
```

Perfil:

- precisa organizar alunos;
- precisa prescrever treinos;
- precisa acompanhar evolução;
- precisa provar valor;
- precisa reduzir churn;
- pode ter dificuldade com ferramentas complexas;
- tende a valorizar praticidade e percepção profissional.

---

## Usuário secundário

```text
Aluno do personal trainer
```

Papel:

- usa a interface para registrar ou acompanhar treino;
- gera dados para o personal;
- percebe valor visual/histórico;
- pode influenciar adoção pelo personal.

---

## Modelo B2B2C

O ActHub vende para o personal, mas parte da adoção pode ser puxada pelo aluno.

Fluxo conceitual:

```text
Aluno usa experiência simples
↓
Aluno percebe evolução
↓
Personal percebe valor
↓
Personal adota como ferramenta de gestão
```

Essa estratégia só funciona se a experiência do aluno for realmente simples.

---

## Fricção zero

A decisão por React PWA está ligada à redução de fricção.

Hipótese:

```text
link via WhatsApp + acesso pelo navegador + possibilidade de instalar na tela inicial reduz barreira de adoção.
```

Cuidado:

Offline-first, Service Worker e IndexedDB não devem ser implementados como cerimônia prematura. Entram quando houver fluxo real que justifique.

---

## Vantagem competitiva

A vantagem pretendida é o “fosso de dados”.

Quanto mais histórico de treino, evolução e performance o ActHub acumula, maior o custo de troca para o personal.

Esse fosso depende de:

- registro consistente;
- visualização clara;
- dados confiáveis;
- evolução histórica;
- utilidade prática;
- baixa fricção.

Se o dado for ruim, o fosso vira passivo.

---

## Motor de progressão

O motor de progressão é o núcleo de diferenciação técnica.

Deve considerar:

- carga;
- repetições;
- RIR;
- RPE;
- 1RM estimado;
- evolução temporal;
- consistência de registro;
- visualização compreensível.

Cuidado:

Cálculos devem ser testados e explicáveis. Erro aqui afeta confiança do produto.

---

## CRM e churn

O CRM deve ajudar o personal a perceber risco de evasão.

Sinais possíveis no futuro:

- queda de frequência;
- queda de registro;
- piora de performance;
- treinos não concluídos;
- tempo sem interação;
- estagnação;
- feedback negativo.

Não implementar modelos complexos de churn cedo demais. Primeiro registrar eventos úteis e aprender com uso real.

---

## Pricing inicial

Pricing legado registrado:

```text
Starter — R$ 69/mês — até 10 alunos
Pro     — R$ 149/mês — até 50 alunos
Elite   — R$ 299/mês — alunos ilimitados
```

Status:

```text
hipótese estratégica inicial
```

Não tratar como contrato final sem validação de mercado.

---

## Tier principal

O tier `Pro` é o candidato natural a core business inicial.

Racional:

- capacidade suficiente para personal com carteira relevante;
- preço intermediário;
- bom equilíbrio entre valor percebido e acessibilidade;
- foco para prospecção física.

---

## Paciente zero

O projeto registra como hipótese de validação inicial o uso de um personal conhecido como paciente zero.

Objetivo:

- validar fluxo real;
- observar fricção;
- testar linguagem de valor;
- medir interesse;
- coletar feedback;
- gerar prova social inicial.

Esse piloto não deve exigir arquitetura grande demais. O foco deve ser aprendizado validado.

---

## Afiliados

Estratégia considerada:

```text
CPA na primeira mensalidade + recorrência menor sem ceder equity.
```

Status:

```text
hipótese de GTM
```

Implementação de afiliados não deve entrar cedo se ainda não houver produto funcional e tracking mínimo.

---

## KPIs relevantes

KPIs iniciais possíveis:

```text
CAC
ativação em 24h
churn rate
número de alunos ativos por personal
frequência de registro de treino
retenção de alunos
conversão de trial para pago
uso semanal pelo personal
```

Cuidado:

Não criar observabilidade de negócio complexa antes de fluxo real de uso.

---

## Princípios de produto

### 1. Simplicidade de adoção

O usuário não deve precisar entender arquitetura para usar.

### 2. Valor visível rápido

O personal precisa perceber rapidamente que o ActHub melhora acompanhamento, organização ou retenção.

### 3. Dados confiáveis

Métrica errada destrói confiança.

### 4. Experiência positiva

A interface deve ter estética positiva, aspiracional e clara.

### 5. Produto antes de automação comercial

Não construir funil complexo antes de validar fluxo principal.

---

## O que não priorizar cedo

Evitar cedo demais:

- marketplace;
- afiliados complexos;
- BI avançado;
- gamificação extensa;
- IA generativa;
- microsserviços;
- app nativo;
- multi-tenant sofisticado além do necessário;
- churn prediction complexo;
- automações comerciais antes de produto utilizável.

---

## Relação com engenharia

Produto e engenharia devem se orientar por dor real.

Quando uma decisão técnica for justificada por GTM, ela deve responder:

```text
Que fricção comercial reduz?
Que aprendizado acelera?
Que risco de produto diminui?
Que métrica melhora?
Qual custo técnico adiciona?
```

---

## Relação com roadmap

GTM forte depende de:

1. fundação técnica estável;
2. fluxo mínimo de personal/aluno;
3. registro de treino;
4. histórico de evolução;
5. primeira visualização de valor;
6. piloto com usuário real;
7. só então monetização mais agressiva.

---

## Declaração final

O ActHub deve evitar parecer sofisticado antes de ser útil.

A estratégia correta é construir valor técnico visível, validar com uso real e só depois aumentar automação comercial.