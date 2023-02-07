# Kafka

## 1. Serviço

- cm1:9092
- cm2:9092
- cm3:9092
- cm4:9092
- gpu1:9092
- gpu2:9092
- gpu3:9092


## 2. Comandos importantes

Leitura de um topico pelo terminal
```bash
$ kafka-console-consumer.sh --topic <nome_topico> --bootstrap-server <endereco_servico>
```

Escrita em um topico pelo terminal
```bash
$ kafka-console-producer.sh --topic <nome_topico> --bootstrap-server <endereco_servico>
```

## 3. Conectores

O Kafka fornece conectores que permitem direcionamento dos dados de um topico para um outro lugar de forma automatica por meio do
Kafka Connect

### 3.1 ElasticSearch

É possível direcionar dados de um tópico para uma índice no ElasticSearch. Para isso, será necessário dois arquivo de configuração: `connect.properties`
e `elastic.properties`, que também podem ser encontrados na pasta `examples/`.

<br>

O arquivo `connect.properties` configura as propriedades do connector, como o formato dos valores e chaves. O tipo do dado a ser inserido no topico do kafka deve ser
um JSON. O `connect.properties` é mostrado a seguir:
```
bootstrap.servers=<endereco_do_kafka>
key.converter=org.apache.kafka.connect.json.JsonConverter
value.converter=org.apache.kafka.connect.json.JsonConverter
key.converter.schemas.enable=false
value.converter.schemas.enable=false
internal.key.converter=org.apache.kafka.connect.json.JsonConverter
internal.value.converter=org.apache.kafka.connect.json.JsonConverter
internal.key.converter.schemas.enable=false
internal.value.converter.schemas.enable=false
offset.storage.file.filename=/tmp/connect.offsets
offset.flush.interval.ms=10000
listeners=http://0.0.0.0:<porta_do_connector>
```
A chave `bootstrap.servers` referece ao endereço do kafka que o conector se conectará e deve ser inserido.
 Já a chave `listeners` se referece ao endereço que o conector irá rodar, o `<porta_do_connector>`
deve ser alterado por uma porta de sua escolha que não esteja sendo usado.

<br>

O arquivo `elastic.properties` se refere a configuração do elasticsearch, como o endereço, usuario e senha, além do nome do topico e do índice. O arquivo `elastic.properties` é
mostrado abaixo:
```
name=elasticsearch-sink-<usuario>
connector.class=io.confluent.connect.elasticsearch.ElasticsearchSinkConnector
tasks.max=1
topics=student-<usuario>-<indice>
key.ignore=true
schema.ignore=true
connection.username=<usuario>
connection.password=<senha>
connection.url=http://cm1:9200
type.name=kafka-connect
drop.invalid.message=true
behavior.on.null.values=IGNORE
behavior.on.malformed.documents=IGNORE
errors.tolerance=all
```
As tags `<usuario>`, `<senha>` e `<indice>` devem ser substituidos. Assim, o conector irá escutar o topico `student-<usuario>-<indice>` e direciona os seus dados para o indice no
ElasticSearch.

<br>

Com os arquivos criados e configurados, é possível iniciar o conector. Para isso, execute o comando a seguir passando o caminho para os arquivos:
```
$ connect-standalone.sh connector.properties elastic.properties
```

