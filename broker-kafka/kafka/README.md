# Executando o exemplo do Kafka

```bash
# Inicie o docker-compose (kafka + zookeper)
$ docker-compose up

# Entre no bash do docker
$ docker exec -it kafka bash

# Crie um tópico
$ kafka-topics.sh --create --topic [nome tópico] --bootstrap-server [ip:porta do kafka]

# Em um outro terminal inicie o consumer
$ pip install -r requirements
$ python ler_kafka.py

# Inicie o producer como um console, ou passando um arquivo
# Obs.: por padrão tudo que estiver na pasta em que o docker é executado estará na pasta /data do container)
$ kafka-console-producer.sh --topic [nome tópico] --bootstrap-server [ip:porta do kafka]

# ou

$ kafka-console-producer.sh --topic [nome tópico] --bootstrap-server [ip:porta do kafka] < /data/seu_arquivo
```
