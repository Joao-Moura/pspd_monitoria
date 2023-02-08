# SSH - Tunneling

Atualmente a chococino só permite acesso externo na porta 13508, que é utilizado para o ssh. Então para acessar algum recurso, seja um servidor web
ou qualquer tipo de socket, rodando no cluster na sua máquina local, é necessário realizar um redirecionamento de porta via ssh.
Esse redirecionamento de porta pode ser feito em dois sentidos, Local Forwarding (local -> remoto) e Remote Forwading (remoto -> local).

## 1. Local Forwarding

O Local Forwading redireciona a porta local da sua máquina para uma porta na máquina remota (chococino). Assim, você consegue ter acesso local
(via localhost) a uma aplicação que está rodando dentro do cluster da chococino. Para isso, usa-se a flag `-L` do ssh. O formato do comando é o seguinte:
```bash
# Na sua máquina local
$ ssh -L <porta_local>:<maquina_remota>:<porta_remota>
# <porta_local>: A porta da sua maquina que será redirecionada a uma porta no cluster
# <maquina_remota> O ip onde a aplicacao está rodando. ex: cm1, cm2, gpu2, gpu3 e etc
# <porta_remota>: A porta que a aplicação está rodando
```

<br>

Um exemplo disso é acessar a interface web do hadoop e spark que rodam, respectivamente, no endereço chococino:9870 e cm1:9090
```bash
# Na sua maquina local
$ ssh -L 9000:chococino:9870 -L 8000:cm1:9090 -p13508 <user>@chococino.naquadah.com.br
```
Assim, quando acessar o localhost:9000 na maquina local, será redirecionado para a aplicacao web do hadoop rodando na chococino:9870,
e o localhost:9000 redireciona para a aplicacao web do spark em cm1:9090

## 2. Remote Forwarding

O Remote Forwarding redireciona uma porta remota, do cluster, para uma porta local. Assim, você consegue ter acesso a aplicacoes rodando na sua
maquina local dentro do cluster. Para isso, é utilizado a flag `-R` do ssh. O formato do comando é o seguinte:
```bash
# Na sua maquina local
$ ssh -R <ip_remoto>:<porta_remota>:<ip_local>:<porta_local>
# <ip_remoto>: Ip da maquina do cluster. Ex: cm1, chococino e etc
# <porta_remota>: Porta que sera redirecionada no cluster
# <ip_local>: Ip para onde vai ser direcionado na maquina local. Ex: localhost, 127.0.0.1
# <porta_local>: Porta pra onde vai ser direcionada na maquina local
```

<br>

Um exemplo, é criar um servidor na web na porta 8000 e acessar dentro do cluster na porta 5000:
```bash
# Na maquina local
# cria o servidor web na porta 8000 e no localhost
$ python3 -m http.server 8000

# Remote forwarding
$ ssh -R chococino:5000:localhost:8000 -p13508 <user>@chococino.naquadah.com.br

# Dentro da chococino
cm1: $ curl chococino:5000
```
