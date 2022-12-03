import pika

import uuid


class FibonacciRpcClient(object):

    def __init__(self):
        # Cria conexão
        self.connection = pika.BlockingConnection(
            pika.ConnectionParameters(host='localhost'))
        self.canal = self.connection.channel()

        # Cria um canal exclusivo para a comunicação (response)
        # Worker -> Cliente
        resultado = self.canal.queue_declare(queue='', exclusive=True)
        self.nome_fila = resultado.method.queue

        self.canal.basic_consume(
            queue=self.nome_fila,
            on_message_callback=self.on_response,
            auto_ack=True
        )

    def on_response(self, canal, metodo, propriedades, corpo):
        # Realiza checagem para evitar que responses
        # de Workers cheguem nos Clientes errados
        if self.corr_id == propriedades.correlation_id:
            self.resposta = corpo

    def call(self, n):
        self.resposta = None
        self.corr_id = str(uuid.uuid4())

        # Realiza a publicação da mensagem na fila do Worker (request)
        self.canal.basic_publish(
            exchange='',
            routing_key='fila_rpc',
            properties=pika.BasicProperties(
                reply_to=self.nome_fila,
                correlation_id=self.corr_id,
            ),
            body=str(n)
        )

        # Entra em loop infinito enquanto não receber uma resposta
        while self.resposta is None:
            self.connection.process_data_events()

        # Finaliza conexão
        self.connection.close()
        return int(self.resposta)


fibonacci_rpc = FibonacciRpcClient()

print("Fibonacci de:")
n = int(input())
resposta = fibonacci_rpc.call(n)
print(f"Resposta: {resposta}")
