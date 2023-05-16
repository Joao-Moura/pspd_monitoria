from kafka import KafkaProducer


producer = KafkaProducer(
    bootstrap_servers='cm1:9092',
    value_serializer=lambda b: b.encode('utf-8')
)

while True:
    producer.send('teste_kafka_pspd', input())
