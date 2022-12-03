import pika

import sys


connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
canal = connection.channel()

canal.exchange_declare(exchange='logs_topico', exchange_type='topic')

gravidade = sys.argv[1] if len(sys.argv) > 1 else 'anon.info'
mensagem = ' '.join(sys.argv[2:]) or "Ola mundo"

canal.basic_publish(
    exchange='logs_topico',
    routing_key=gravidade,
    body=mensagem,
)

print("[x] Mensagem enviada")
connection.close()
