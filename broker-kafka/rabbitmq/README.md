# Executando os exemplos do RabbitMQ

```bash
# Inicie o RabbitMQ (comando retirado da documentação)
$ docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.9-management

# Inicie o receive (ou worker)
$ python receive[0-5]/worker.py

# Por fim, execute o sender (ou cliente)
$ python send[0-5]/client.py
```
