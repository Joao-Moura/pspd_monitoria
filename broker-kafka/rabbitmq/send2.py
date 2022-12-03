import pika

import sys


connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
canal = connection.channel()

canal.queue_declare(queue='exemplo2', durable=True)

mensagem = ' '.join(sys.argv[1:]) or "Ola mundo"
canal.basic_publish(
    exchange='',
    routing_key='exemplo2',
    body=mensagem,
    properties=pika.BasicProperties(
        delivery_mode=pika.spec.PERSISTENT_DELIVERY_MODE
    )
)

print("[x] Mensagem enviada")
connection.close()
