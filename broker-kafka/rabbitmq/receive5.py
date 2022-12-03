import pika

import sys


def main():
    connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
    canal = connection.channel()

    canal.exchange_declare(exchange='logs_topico', exchange_type='topic')

    result = canal.queue_declare(queue='', exclusive=True)
    nome_fila = result.method.queue

    gravidades = sys.argv[1:]
    for gravidade in gravidades:
        canal.queue_bind(
            exchange='logs_topico',
            queue=nome_fila,
            routing_key=gravidade
        )

    def callback(canal, metodo, propriedades, corpo):
        print(f"[x] Recebido: {corpo.decode()}")

    canal.basic_consume(
        queue=nome_fila,
        on_message_callback=callback,
        auto_ack=True
    )

    print('[*] Esperando mensagens. CTRL+C para sair')
    canal.start_consuming()


if __name__ == '__main__':
    main()
