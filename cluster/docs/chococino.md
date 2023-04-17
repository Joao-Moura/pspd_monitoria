# Chococino

## 1. Ambiente

### 1.1 Máquinas disponíveis


|Máquina  |CPU         |Memória |GPU    |
|---------|------------|------- |-------|
|Chococino|Ryzen 7 2700|16GB    | ----- |
|CM1      |i7-8700     |16GB    | ----- |
|CM2      |i7-8700     |16GB    | ----- |
|CM3      |i7-8700     |16GB    | ----- |
|CM4      |i7-8700     |16GB    | ----- |
|POS1     |i7-9700     |16GB    | ----- |
|POS2     |i7-9700     |16GB    | ----- |
|GPU1     |Ryzen 7 2700|32GB    |GTX1650|
|GPU2     |Ryzen 7 2700|32GB    |GTX1650|
|GPU3     |Ryzen 7 2700|32GB    |GTX1650|

### 1.2 Serviços

|Serviço |Nome       |Endereço                 |
|--------|-----------|-------------------------|
|Hadoop  |Namenode   |hdfs://chococino:9000    |
|Hadoop  |Namenode UI|http://chococino:9870    |
|Spark   |Master     |spark://cm1:7077         |
|Spark   |Master UI  |http://cm1:9090          |
|Zookeper|Zookeper   |cm2:2181                 |
|Kafka   |Kafka node |[cm1-cm4, gpu1-gpu3]:9092|
|Elastic |Elastic    |http://cm1:9200          |
|Kibana  |Kibana UI  |http://cm4:5601          |

## 2. Acesso

```bash
# Na maquina local
$ ssh -p13508 <user>@chococino.naquadah.com.br
```

## 3. Navegação

Para navegar entre as maquinas, basta utilizar o comando ssh mais o hostname da maquina que você deseja ir
```bash
# Dentro do cluster chococino
$ ssh chococino
$ ssh cm1
$ ssh cm2
$ ssh cm3
...
$ ssh gpu1
...
$ ssh gpu3
$ ssh pos1
$ ssh pos2
```

Para navegar sem precisar de senha entre as máquinas, é necessário criar uma chave e autorizar ela
```bash
# Dentro do cluster chococino
$ ssh-keygen -t rsa
$ cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

## 4. Acesso ao serviços

Vários serviços estão funcionando no cluster chococino, como o Apache Hadoop, Apache Spark, Apache Kafka, ElasticSearch e Kibana. Para interagir com
esse serviços é preciso entrar no ambiente. Para isso, execute o comando:
```bash
# Dentro do cluster chococino
$ source /home/prof/hadoop/bin/chococino_env
```

Esse comando irá exportar as váriaveis que permitem a interação com os servicos, mas só durante a sessão do ssh. Para acesso definitivo, use o comando:
```bash
$ echo "source /home/prof/hadoop/bin/chococino_env" >> $HOME/.bashrc
```
