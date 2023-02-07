# Spark

## 1. Serviços

- cm1:7077	Spark Master
- cm1:9090	Spark WebUI

## 2. Acesso a WebUI

```bash
# na sua maquina local
$ ssh -L 9090:cm1:9090 -p13508 <user>@chococino.naquadah.com.br

# Acesse no navegador da sua maquina local o endereço http://localhost:9090
```

## 3. Acesso ao PySpark

```bash
# na sua maquina local
$ pyspark --master spark://cm1:7077

# Agora é possível utilizar o terminal com comandos Python e
# com a biblioteca do PySpark
```

## 4. Comandos importantes

- Importação do Pyspark
```python
>>> from pyspark.sql import SparkSession
```

- Conectando com o Spark

```python
spark = SparkSession.builder \
	.master("spark://cm1:7077") \
	.appName("seu_nome_aqui") \
	.getOrCreate()
```

- Lendo arquivos do Hadoop

```python
arquivo = spark.read.text("hdfs://chococino:9000/user/sua_pasta/seu_arquivo")
```

- Lendo arquivos CSV do Hadoop (inferindo tipos e com os _headers_)

```python
csv = spark.read \
	.option('header', True) \
	.option('inferSchema' , True) \
	.csv("hdfs://chococino:9000/user/sua_pasta/seu_arquivo")
```

- Lendo mensagens do Kafka

```python
mensagem = spark.readStream \
	.format("kafka") \
	.option("kafka.bootstrap.servers", "cm4:9092") \
	.option("subscribe", "seu_topico") \
	.option('includeTimestamp', 'true') \
	.load()
```

## 5. Utilizando o SQL do PySpark

- Filtrando a _query_

```python
query.filter(query.nome_da_sua_coluna == "comparação").show()
```

- Selecionando colunas (projeção de dados)

```python
query.select(query.sua_coluna_1, query.sua_coluna_2, query.quantas_colunas_quiser).show()
```

- Agrupando e fazendo a soma

```python
query.select(query.coluna_1, query.coluna_2) \
	.groupBy(query.coluna_1, query.quantas_colunas_quiser) \
	.sum('aqui_sua_coluna_em_string').show()
```

- Para ver a documentação de mais comandos
Acesse: [https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/index.html](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/index.html)
