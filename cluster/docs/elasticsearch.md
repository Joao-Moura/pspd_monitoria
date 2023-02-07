# ElasticSearch

- cm1:9200


# 2. Administração

- Iniciar o elasticsearch com o Kibana
```bash
$ elastic-start-all.sh
```

- Desligar o Elasticsearch e o Kibana
```bash
$ elastic-stop-all.sh
```

- Resetar a senha de um usuário
```bash
$ $ELASTIC_BIN_HOME/bin/elasticsearch-reset-password --auto --username <username>
```

- Criar um novo aluno com spaces, roles
```bash
$ export ELASTIC_APIKEY=<elastic_key>
$ create_elastic_student.sh <username> <password>
```

