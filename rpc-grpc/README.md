# gRPC & ProtoBuf como solução de mensageria - LAB02

## Python

Instale as dependencias:<br>
`$ pip install -r requirements.txt`<br>

Inicie o servidor passando a quantidade de workers e a porta:<br>
`$ python python/minmax_server.py 4 50051`<br>

Rode o cliente passando o ip e a porta do servidores:<br>
`$ python python/minmax_client.py 127.0.0.1:50051`<br>

Exemplo do cliente com multiplos servidores:<br>
`$ python python/minmax_client.py 127.0.0.1:50051 IP2:PORT2 IP3:PORT3`

<hr>

## Haskell

Como o haskell nao possui suporte oficial ao gRPC, a biblioteca utilizada, [gRPC-Haskell](https://github.com/awakesecurity/gRPC-haskell), utilizada o gRPC do C++ e apresenta diversos problemas de compatibilidade, então preparar o ambiente pode demorar vários minutos. <strong>É necessário possuir o GHC, cabal, git e o nix-build instalado na maquina</strong><br>

Clone o repositorio do gRPC-Haskell:<br>
`$ git clone https://github.com/awakesecurity/gRPC-haskell`<br>

Va para a raiz do repositorio gRPC-HASKELL:<br>
`$ cd gRPC-haskell`<br>

Builde o ambiente:<br>
`$ nix-build release.nix -A grpc-haskell`<br>

Entre no shell do nix:<br>
`$ nix-shell`<br>

No shell do nix, com o servidor Python rodando em 127.0.0.1:50051, vá para a pasta do laborátorio de gRPC e execute o cliente haskell:<br>
`$ cabal run`