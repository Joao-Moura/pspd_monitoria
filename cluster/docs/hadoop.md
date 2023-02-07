# Hadoop

## 1. Serviços

- chococino:9000	Namenode
- chococino:9870	Namenode WebUI

## 2. Acesso a WebUI

```bash
# na sua maquina local
$ ssh -L 9870:chococino:9870 -p13508 <user>@chococino.naquadah.com.br

# Acesse no navegador da sua maquina local o endereço http://localhost:9870
```

## 3. Comandos importantes

- Criação de pastas
```
$ hdfs dfs -mkdir <nome_pasta>

# por padrao, a pasta será criada na sua home do hdfs, que é em /user/<usuario>
```

- Listagem dos diretórios
```bash
# Listagem da sua home em /user/<usuario>
$ hdfs dfs -ls

$ hdfs dfs -ls <pasta>
```

- Remoção
```bash
$ hdfs dfs -rm <arquivo>
$ hdfs dfs -rm -r <pasta>
```

- Adicao de arquivos
```bash
$ hdfs dfs -put <nome_arquivo_local> <nome_arquivo_no_hdfs>
```

- Leitura
```bash
$ hdfs dfs -cat <arquivo>
$ hdfs dfs -head <arquivo>
```

- Mais comandos
```bash
$ hdfs dfs --help
```

## 4. Administração

- Iniciar o hadoop
```bash
$ hadoop-start-all.sh
```

- Desligar o hadoop
```bash
$ hadoop-stop-all.sh
```

- Criação de usuários
```bash
$ create_hadoop_user.sh <username> <quota_size>
```

