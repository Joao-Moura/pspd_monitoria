


# Acessando uma aplicação do cluster

```
$ ssh -L <LOCAL_PORT>:<NODE_HOSTNAME>:<NODE_PORT> <user>@<ip>
```

Por exemplo, acessar a interface web do NodeManager na porta local `8000` na porta `9070` do host `cm3`
```
$ ssh -L 8000:cm3:9070 <user>@<ip>
$ curl localhost:8000
```