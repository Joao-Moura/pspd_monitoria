import pika

import sys


connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
canal = connection.channel()

canal.exchange_declare(exchange='logs_diretos', exchange_type='direct')

gravidade = sys.argv[1] if len(sys.argv) > 1 else 'info'
mensagem = ' '.join(sys.argv[2:]) or "Ola mundo"

canal.basic_publish(
    exchange='logs_diretos',
    routing_key=gravidade,
    body=mensagem,
)

print("[x] Mensagem enviada")
connection.close()
