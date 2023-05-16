from kafka import KafkaConsumer


consumer = KafkaConsumer(
    'teste_kafka_pspd', bootstrap_servers='gpu3:9092',
    value_deserializer=lambda b: b.decode('utf-8').split()
)

# while True:
for msg in consumer:
    print(f'[MENSGEM RECEBIDA] - {" ".join(msg.value)}')
