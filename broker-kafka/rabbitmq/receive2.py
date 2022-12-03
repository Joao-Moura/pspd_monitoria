import pika

import time


def main():
    connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
    canal = connection.channel()

    canal.queue_declare(queue='exemplo2', durable=True)

    def callback(canal, metodo, propriedades, corpo):
        print(f"[x] Recebido: {corpo.decode()}")
        time.sleep(corpo.count(b'.'))
        print("[x] Feito")
        canal.basic_ack(delivery_tag=metodo.delivery_tag)

    canal.basic_qos(prefetch_count=1)
    canal.basic_consume(
        queue='exemplo2',
        on_message_callback=callback
    )

    print('[*] Esperando mensagens. CTRL+C para sair')
    canal.start_consuming()


if __name__ == '__main__':
    main()
