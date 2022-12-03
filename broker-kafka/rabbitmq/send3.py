import pika

import sys


connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
canal = connection.channel()

canal.exchange_declare(exchange='logs', exchange_type='fanout')

mensagem = ' '.join(sys.argv[1:]) or "Ola mundo"
canal.basic_publish(
    exchange='logs',
    routing_key='',
    body=mensagem,
)

print("[x] Mensagem enviada")
connection.close()
