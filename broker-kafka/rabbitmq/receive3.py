import pika

import time


def main():
    connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
    canal = connection.channel()

    canal.exchange_declare(exchange='logs', exchange_type='fanout')

    result = canal.queue_declare(queue='', exclusive=True)
    nome_fila = result.method.queue

    canal.queue_bind(exchange='logs', queue=nome_fila)

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
