import pika


connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
canal = connection.channel()

canal.queue_declare(queue='exemplo1')

canal.basic_publish(
    exchange='',
    routing_key='exemplo1',
    body='Ola mundo'
)

print("[x] Mensagem enviada")
connection.close()
