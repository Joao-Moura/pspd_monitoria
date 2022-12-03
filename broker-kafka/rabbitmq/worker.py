import pika


# Cria conexão
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
canal = connection.channel()

# Cria um canal exclusivo para a comunicação (request)
# Cliente -> Worker
canal.queue_declare(queue='fila_rpc')

def fib(n):
    if n == 0 or n == 1:
        return n
    else:
        return fib(n-1) + fib(n-2)

def on_request(canal, metodo, propriedades, corpo):
    n = int(corpo)
    print(f'Calculando fib({n})')
    response = fib(n)

    # Publica mensagem no canal exclusivo do cliente
    # através propriedade reply_to settada no Client
    canal.basic_publish(
        exchange='', routing_key=propriedades.reply_to,
        properties=pika.BasicProperties(
            correlation_id=propriedades.correlation_id),
        body=str(response)
    )
    canal.basic_ack(delivery_tag=metodo.delivery_tag)

# Utiliza a divisão justa de tarefas
canal.basic_qos(prefetch_count=1)
canal.basic_consume(queue='fila_rpc', on_message_callback=on_request)

print('[*] Esperando mensagens. CTRL+C para sair')
canal.start_consuming()
