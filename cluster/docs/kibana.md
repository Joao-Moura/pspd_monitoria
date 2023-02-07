# Kibana

## 1. Serviço

- http://cm4:5601

## 2. Acesso

```bash
# Na maquina local
$ ssh -L 5601:cm4:5601 -p1305 <user>@chococino.naquadah.com.br
```

# 3. Administração

- Iniciar o elasticsearch com o Kibana
```bash
$ elastic-start-all.sh
```

- Desligar o Elasticsearch e o Kibana
```bash
$ elastic-stop-all.sh
```

- Criar um novo aluno com spaces e roles
```bash
$ export ELASTIC_APIKEY=<elastic_key>
$ create_elastic_student.sh <username> <password>
```
