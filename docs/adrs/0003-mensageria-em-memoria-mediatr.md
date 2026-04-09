# 0003 - Mensageria em Memória (MediatR)

## Status
Accepted

## Context
Ao organizar o software em módulos lógicos isolados (Monolito Modular - ADR 0001), o problema da comunicação inter-módulo precisa ser resolvido. No modelo de Bounded Contexts estritos, os módulos (como Identity e TrainingPlanning) não podem instanciar nem invocar métodos uns dos outros para evitar acoplamento forte em tempo de compilação. Um Message Broker completo (RabbitMQ, Kafka ou Azure Service Bus) solucionaria o problema enviando eventos assíncronos, porém incorreria num alto custo financeiro mensal na nuvem e num enorme peso na configuração e observabilidade para a Fase 1 do projeto.

## Decision
Para garantir a independência entre os contextos delimitados sem onerar a infraestrutura, a comunicação será puramente assíncrona baseada em eventos (*Domain Events* e *Integration Events* virtuais) geridos em memória RAM, utilizando o padrão Publish/Subscribe da biblioteca **MediatR**. 

## Consequences
- **Positivas:** 
    - Módulos se comunicam via disparo de notificações e não sabem qual outro módulo vai tratar esse evento. (Baixo Acoplamento, Alta Coesão).
    - Custo de infraestrutura é ZERO, a latência de tráfego é quase instantânea e nenhuma complexidade de rede ou mensageria externa é inserida.
    - Facilita uma migração futura perfeita. Quando o sistema precisar de escala horizontal via mensageria real (Azure Service Bus), basta substituir os Handlers in-memory do MediatR por publishers de um barramento externo.
- **Negativas:**
    - Se o processo da aplicação falhar/crashing exatamente no momento em que um evento foi publicado e ainda não processado pelo subscriber em background, essa mensagem é perdida irreversivelmente (já que está apenas na memória volátil). Isso requer resiliência local e estratégias como o padrão *Outbox* se a transação inter-módulos passar a ser crítica.
