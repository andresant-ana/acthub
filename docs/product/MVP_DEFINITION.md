# MVP_DEFINITION — ActHub

## Finalidade

Este documento define a linha de chegada do MVP do ActHub.

Ele existe para responder:

```text
O que precisa existir para o ActHub ser considerado um MVP?
O que fica fora do MVP?
Qual é a ordem lógica de entrega?
Quais critérios tornam o MVP validável?
Quais riscos bloqueiam o MVP?
```

Este documento não substitui `PROJECT_STATE.md`, `PROJECT_ROADMAP.md`, GitHub Issues, ADRs ou documentação técnica local.

---

## Tese do MVP

O MVP do ActHub deve provar que um personal trainer consegue:

```text
cadastrar alunos
prescrever treinos
disponibilizar o treino para o aluno
receber registros de execução
acompanhar evolução básica
perceber valor suficiente para continuar usando
```

O MVP não precisa provar escala, marketplace, afiliados, IA, BI avançado ou operação multi-tenant sofisticada.

---

## Definição curta

```text
MVP = um fluxo funcional privado, utilizável por um personal trainer real e seus alunos, cobrindo gestão básica, prescrição de treino, execução registrada e visualização inicial de progresso.
```

---

## Natureza do MVP

O MVP é:

```text
private pilot MVP
```

Não é:

```text
public SaaS launch
produto final
plataforma multi-tenant madura
sistema enterprise
app nativo
marketplace
```

O objetivo é validar valor real com uso controlado antes de ampliar escopo técnico e comercial.

---

## Usuário-alvo do MVP

### Cliente primário

```text
personal trainer
```

Precisa conseguir:

- entrar no sistema;
- cadastrar alunos;
- organizar alunos ativos;
- criar ou montar treinos;
- atribuir treino a aluno;
- visualizar execução;
- acompanhar evolução básica.

---

### Usuário secundário

```text
aluno do personal trainer
```

Precisa conseguir:

- acessar treino com baixa fricção;
- visualizar treino prescrito;
- registrar execução;
- informar carga, repetições e percepção de esforço quando aplicável;
- acompanhar evolução simples.

---

## Hipótese principal

```text
Se o personal trainer conseguir prescrever treinos e visualizar evolução real dos alunos com menos fricção do que planilhas, WhatsApp ou anotações manuais, então o ActHub tem valor suficiente para avançar além do MVP.
```

---

## Métrica qualitativa principal

O MVP é bem-sucedido se o personal trainer disser, após uso real:

```text
isso me ajuda a acompanhar meus alunos melhor do que meu método atual
```

---

## Métricas iniciais de validação

Métricas possíveis:

```text
número de alunos cadastrados
número de treinos prescritos
número de sessões registradas
frequência de uso semanal pelo personal
frequência de registro pelos alunos
tempo para criar um treino
tempo para registrar uma sessão
feedback qualitativo do personal
feedback qualitativo dos alunos
```

Não implementar analytics sofisticado antes de fluxo funcional real.

---

# Escopo do MVP

## 1. Identity & Access mínimo

### Deve ter

- cadastro/login básico;
- perfil de personal trainer;
- perfil de aluno;
- associação aluno-personal;
- autorização básica para impedir acesso cruzado;
- proteção backend das rotas sensíveis.

### Pode ser simples

- sem social login;
- sem SSO;
- sem MFA;
- sem tiers completos;
- sem billing;
- sem organização multi-empresa.

### Critério de pronto

O personal não pode acessar dados de outro personal.

O aluno não pode acessar treino ou dados de outro aluno.

Autorização deve estar no backend, não apenas no frontend.

### Risco

```text
R3
```

Auth/authz não deve ser tratada como task simples.

---

## 2. CRM básico de alunos

### Deve ter

Para o personal:

- listar alunos;
- cadastrar aluno;
- editar dados básicos;
- ativar/desativar aluno;
- visualizar detalhes de aluno.

Dados mínimos do aluno:

```text
nome
email ou identificador de acesso
status
observações básicas
data de criação
vínculo com personal
```

### Fora do MVP

- funil comercial;
- automação de mensagens;
- CRM avançado;
- lead scoring;
- churn prediction;
- segmentações complexas.

### Critério de pronto

Um personal consegue organizar sua base mínima de alunos e selecionar um aluno para prescrever treino.

---

## 3. Catálogo mínimo de exercícios

### Deve ter

- lista inicial de exercícios;
- nome;
- grupo muscular ou categoria;
- metadados mínimos úteis para prescrição.

### Pode ser simples

- seed manual;
- CRUD restrito;
- sem biblioteca pública completa;
- sem vídeos;
- sem mídia pesada;
- sem variações avançadas.

### Critério de pronto

O personal consegue montar um treino usando exercícios cadastrados.

---

## 4. Prescrição de treino

### Deve ter

O personal consegue criar um treino para um aluno contendo:

```text
nome do treino
descrição opcional
lista de exercícios
séries
repetições alvo
carga alvo opcional
RIR/RPE alvo opcional
observações por exercício
ordem dos exercícios
```

### Deve permitir

- atribuir treino a aluno;
- editar treino antes de execução;
- visualizar treino prescrito.

### Fora do MVP

- periodização avançada;
- macrociclos completos;
- drag-and-drop sofisticado;
- templates complexos;
- prescrição coletiva;
- biblioteca avançada de protocolos;
- automação inteligente de progressão.

### Critério de pronto

Um personal consegue prescrever um treino real que um aluno consegue executar sem depender de planilha externa.

---

## 5. Execução de treino pelo aluno

### Deve ter

O aluno consegue:

- visualizar treino atribuído;
- iniciar execução;
- marcar exercício como feito;
- registrar carga usada;
- registrar repetições realizadas;
- registrar RIR ou RPE quando aplicável;
- finalizar sessão.

### Pode ser simples

- sem offline-first completo;
- sem timer avançado;
- sem wearable;
- sem chat;
- sem upload de mídia.

### Critério de pronto

Uma sessão de treino real pode ser registrada do início ao fim.

---

## 6. Histórico de execução

### Deve ter

Para o personal:

- ver histórico de sessões por aluno;
- ver exercícios executados;
- ver carga/repetições registradas;
- identificar última execução de um exercício.

Para o aluno:

- ver histórico básico próprio.

### Fora do MVP

- dashboards avançados;
- BI;
- rankings;
- comparação social;
- relatórios exportáveis;
- gráficos complexos.

### Critério de pronto

O personal consegue responder:

```text
como esse aluno executou o treino mais recente?
```

---

## 7. Progressão básica

### Deve ter

Para exercícios selecionados, o sistema deve conseguir mostrar evolução simples de:

```text
carga
repetições
volume aproximado
1RM estimado, se a fórmula for implementada com teste
```

### Regras

- cálculo precisa ser testado;
- fórmula precisa ser explícita;
- arredondamento precisa ser previsível;
- não alterar algoritmo silenciosamente.

### Fora do MVP

- modelo avançado de progressão;
- IA;
- recomendações automáticas sofisticadas;
- análise biomecânica real;
- periodização automática.

### Critério de pronto

O personal consegue perceber se o aluno está evoluindo, estagnado ou regredindo em exercícios relevantes.

---

## 8. Interface PWA mínima

### Deve ter

- interface do personal;
- interface do aluno;
- fluxo responsivo;
- acesso por navegador;
- experiência instalável PWA se já estiver suportada pela base atual;
- navegação simples.

### Pode ser simples

- sem design system completo;
- sem animações;
- sem offline-first completo;
- sem push notifications;
- sem app nativo.

### Critério de pronto

O aluno consegue acessar e registrar treino pelo celular sem fricção excessiva.

---

## 9. Operação mínima

### Deve ter

- build backend passando;
- build frontend passando;
- pipeline de qualidade mínimo;
- configuração por ambiente sem segredo no repo;
- documentação local atualizada;
- comandos registrados em `LOCAL_COMMANDS.md`;
- riscos registrados em `RISK_SURFACES.md`;
- critérios de pronto respeitados.

### Antes de uso real controlado

Precisa haver:

- forma segura de configurar banco;
- forma segura de configurar secrets;
- deploy controlado ou ambiente local/piloto claramente definido;
- rollback/manual recovery proporcional ao estágio.

---

# Fora do escopo do MVP

Não entra no MVP:

```text
microsserviços
Kubernetes
CQRS global
Event Sourcing
app nativo
marketplace de personais
billing completo
assinaturas reais
afiliados
IA generativa
churn prediction avançado
BI avançado
gamificação extensa
chat interno
push notification obrigatória
offline-first completo
multi-tenant enterprise
dashboard financeiro
integração com wearables
upload de vídeos
biblioteca completa de exercícios
automação completa de periodização
```

Esses itens podem entrar depois, se houver dor real e validação de produto.

---

# Sequência de entrega do MVP

## Marco 0 — Fundação operacional

Objetivo:

```text
deixar o repo pronto para execução confiável com agentes
```

Inclui:

- documentação local do harness;
- `AGENTS.md` migrado;
- pipeline backend build;
- análise estática;
- frontend build;
- validação Terraform em CI;
- estrutura inicial de testes;
- comandos locais confiáveis.

Status atual:

```text
em andamento
```

---

## Marco 1 — Base de domínio e testes

Objetivo:

```text
criar base mínima para desenvolver domínio sem quebrar arquitetura
```

Inclui:

- projetos de teste backend;
- convenção de testes;
- primeira fatia vertical simples;
- persistência local controlada;
- modelo inicial de entidades principais;
- migrations locais.

---

## Marco 2 — Identity & CRM mínimo

Objetivo:

```text
permitir personal e aluno existirem no sistema com vínculo seguro
```

Inclui:

- cadastro/login básico;
- perfis personal/aluno;
- autorização backend básica;
- CRUD mínimo de alunos;
- vínculo aluno-personal.

Risco:

```text
R3
```

---

## Marco 3 — Prescrição de treino

Objetivo:

```text
permitir que o personal crie e atribua treinos
```

Inclui:

- catálogo mínimo de exercícios;
- treino;
- exercícios do treino;
- séries/repetições/carga/RIR/RPE alvo;
- atribuição para aluno;
- visualização do treino.

---

## Marco 4 — Execução do treino

Objetivo:

```text
permitir que o aluno registre uma sessão real
```

Inclui:

- tela de treino do aluno;
- início/finalização de sessão;
- registro de exercício;
- carga/repetições/RIR/RPE;
- persistência do histórico.

---

## Marco 5 — Histórico e progressão básica

Objetivo:

```text
mostrar valor técnico ao personal
```

Inclui:

- histórico por aluno;
- histórico por exercício;
- evolução de carga/repetições;
- volume básico;
- 1RM estimado se houver teste e fórmula definida;
- visualização simples.

---

## Marco 6 — Piloto controlado

Objetivo:

```text
validar uso real com personal e poucos alunos
```

Inclui:

- ambiente controlado;
- dados reais com cuidado;
- feedback do personal;
- feedback dos alunos;
- observação de fricção;
- lista de correções antes de expansão.

---

# Critérios de conclusão do MVP

O MVP está concluído quando:

```text
1. Um personal consegue acessar o sistema.
2. Um personal consegue cadastrar alunos.
3. Um personal consegue criar treino.
4. Um personal consegue atribuir treino a aluno.
5. Um aluno consegue acessar o treino.
6. Um aluno consegue registrar execução real.
7. O personal consegue ver histórico de execução.
8. O personal consegue ver progressão básica.
9. O sistema protege acesso entre personal/aluno.
10. Backend e frontend possuem build validável.
11. Há testes para regras/cálculos críticos.
12. Não há segredo no repositório.
13. Deploy/ambiente de piloto está definido.
14. Documentação operacional mínima está atualizada.
15. O piloto gera feedback real suficiente para decidir próxima fase.
```

---

# Critérios de não conclusão

O MVP não está concluído se:

- só existir scaffolding;
- só existir frontend mockado;
- o aluno não conseguir registrar execução;
- o personal não conseguir ver histórico;
- auth/autorização forem apenas frontend;
- não houver persistência real;
- não houver build confiável;
- cálculos críticos não tiverem teste;
- houver segredo exposto;
- o sistema depender de operação manual frágil não documentada;
- não houver usuário real ou piloto controlado.

---

# Critérios de qualidade mínima

## Backend

- compila;
- tem testes para regra crítica;
- respeita bounded contexts;
- não cria acoplamento indevido;
- valida input externo;
- aplica autorização no backend.

## Frontend

- build passa;
- fluxo principal é usável no celular;
- não assume autoridade de segurança;
- comunica erros básicos;
- não armazena dado sensível indevidamente.

## Dados

- persistência real definida;
- migrations locais testadas;
- schema mínimo coerente;
- dados de aluno protegidos;
- queries respeitam vínculo personal-aluno.

## Operação

- comandos documentados;
- pipeline mínimo existe;
- secrets fora do repo;
- ambiente de piloto definido;
- rollback/manual recovery proporcional.

---

# Riscos bloqueantes

Bloqueiam MVP:

- auth/autorização insegura;
- vazamento entre alunos/personais;
- segredo no repo;
- ausência de persistência real;
- cálculo crítico incorreto sem teste;
- execução de treino não registrável;
- ausência de build backend/frontend;
- ambiente de piloto indefinido;
- dependência de processo manual não documentado.

---

# Relação com GTM

O MVP deve validar uso antes de monetização agressiva.

Não construir agora:

- billing;
- afiliados;
- automação comercial;
- marketplace;
- dashboard de vendas.

Primeiro validar:

```text
personal entende valor?
aluno consegue usar?
registro de treino acontece?
histórico gera percepção de evolução?
```

---

# Relação com arquitetura

A arquitetura do MVP deve continuar seguindo:

```text
Monólito Modular
Vertical Slice Architecture
Bounded Contexts
PostgreSQL
React PWA
Azure/Terraform quando necessário
```

Não introduzir complexidade nova sem dor real.

---

# Relação com agentes

Toda task do MVP deve ser tratada por risco.

Especial atenção para:

```text
auth/authz
multi-tenancy
dados de aluno
migrations
Terraform
Azure
deploy
cálculos de progressão
```

Essas áreas exigem plano, validação e review proporcional.

---

# Primeiro piloto técnico recomendado

Antes de iniciar feature de domínio, concluir uma task pequena de fundação.

Candidatos:

```text
pipeline de análise estática
pipeline frontend build
validação Terraform em CI
estrutura inicial de testes backend
```

A primeira task não deve ser auth, banco real, deploy ou Terraform apply.

---

## Declaração final

O MVP do ActHub não é uma demonstração de arquitetura.

O MVP é a menor versão capaz de provar valor real para um personal trainer acompanhando alunos reais ou semi-reais, com prescrição, execução registrada e progressão visível.