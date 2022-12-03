import pika


def main():
    connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
    canal = connection.channel()

    canal.queue_declare(queue='exemplo1')

    def callback(canal, metodo, propriedades, corpo):
        print(f"[x] Recebido: {corpo}")

    canal.basic_consume(
        queue='exemplo1',
        auto_ack=True,
        on_message_callback=callback
    )

    print('[*] Esperando mensagens. CTRL+C para sair')
    canal.start_consuming()


if __name__ == '__main__':
    main()
