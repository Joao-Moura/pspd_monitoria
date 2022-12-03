from kafka import KafkaConsumer

from wordcloud import WordCloud
import matplotlib.pyplot as plt

import threading


def desenha_cloud(palavras, consumer):
    for msg in consumer:
        for word in msg.value:
             palavras[word] = palavras.get(word, 0) + 1


consumer = KafkaConsumer(
    'teste', bootstrap_servers='localhost:9092',
    value_deserializer=lambda b: b.decode('utf-8').split()
)

palavras = {}
threading.Thread(target=desenha_cloud, args=(palavras, consumer), daemon=True).start()

while True:
    if not palavras:
        continue

    wc = WordCloud(
        background_color="white",
        width=1000, height=1000,
        max_words=200, relative_scaling=0.5,
    ).generate_from_frequencies(palavras)
    
    plt.imshow(wc)
    plt.axis("off")
    plt.draw()
    plt.pause(1)
