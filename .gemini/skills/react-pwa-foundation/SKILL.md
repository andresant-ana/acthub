---
name: react-pwa-foundation
description: >
  Use OBRIGATORIAMENTE quando a tarefa envolver a criação da fundação inicial do
  front-end React do ActHub com base PWA, sem implementar telas de negócio.
---

# Skill: React PWA Foundation

## Objetivo
Esta skill orienta a criação do esqueleto inicial do front-end do ActHub em React,
com base compatível com PWA, sem antecipar fluxo de aluno, CRM do personal,
sincronização offline completa ou lógica de produto.

## Quando usar
Use esta skill quando a tarefa envolver:
- criação do projeto React com Vite;
- organização estrutural inicial do front-end;
- preparação de base compatível com PWA;
- definição do app shell inicial;
- estrutura mínima para futura evolução das telas.

## Quando NÃO usar
Não use esta skill para:
- construir telas completas do aluno;
- construir dashboard CRM do personal;
- implementar offline-first completo;
- persistir dados em IndexedDB;
- sincronizar treinos offline com back-end;
- modelar estado de negócio;
- implementar autenticação;
- consumir APIs reais.

Nesses casos, a tarefa já está em fase posterior.

## Regras arquiteturais invioláveis
1. A fundação deve ser compatível com a estratégia de fricção zero do projeto.
2. O front-end deve nascer limpo, mínimo e preparado para futura evolução.
3. Não criar componentes excessivos sem necessidade real.
4. Não transformar o scaffolding em design system completo.
5. Não acoplar o front-end a APIs ou contratos que ainda não existem.
6. Não antecipar regras de domínio da jornada do aluno ou do personal trainer.

## Diretriz de PWA para esta fase
Nesta etapa, "PWA foundation" significa:
- base React com Vite;
- estrutura inicial de diretórios;
- preparo para manifest e instalação progressiva, se o plano exigir;
- app shell mínimo;
- organização saudável para expansão futura.

Nesta etapa, NÃO significa:
- offline-first completo;
- fila de sincronização;
- IndexedDB funcional;
- estratégia real de cache para fluxos de negócio;
- telemetria de uso;
- gamificação;
- gráficos de performance.

## Diretrizes de estrutura
- Use nomes em Inglês.
- Crie apenas a estrutura mínima aprovada no plano.
- Prefira simplicidade.
- Evite abstrações vazias.
- Não crie arquitetura de front-end excessivamente rebuscada no scaffolding inicial.

## Restrições de implementação
Durante esta fundação, NÃO:
- implemente páginas de domínio reais;
- crie integrações com API;
- invente gerenciamento global de estado sem necessidade;
- adicione bibliotecas extras sem justificativa explícita;
- escreva lógica offline completa;
- modele dados de treino.

## Formato de entrega esperado
Ao usar esta skill, o agente deve:
1. informar os caminhos completos dos arquivos criados ou alterados;
2. explicar brevemente a função da estrutura gerada;
3. manter o foco em fundação, não em feature;
4. informar os comandos mínimos para validar a inicialização local.

## Comandos de validação sugeridos
Use apenas se fizer sentido para o plano aprovado:

```bash
node -v
npm -v
npm install
npm run build
npm run dev
```

## Regra final
Se o pedido começar a exigir comportamento de produto, jornada real de usuário,
sincronização offline ou integração com API, interrompa e reporte que o escopo
ultrapassou a fundação inicial do front-end.