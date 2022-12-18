FROM ubuntu:latest

RUN apt-get update && \
    apt install openssh-server \
    openjdk-8-jre-headless

RUN export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

RUN adduser user_teste
RUN service ssh start

ARG PORT_WEBUI
ARG PORT_MASTER

RUN ssh -L PORT_WEBUI:127.0.0.1:PORT_WEBUI \
    -L PORT_MASTER:127.0.0.1:PORT_MASTER \
    -p 22 ubuntu1@localhost

RUN wget https://dlcdn.apache.org/spark/spark-3.3.1/spark-3.3.1-bin-hadoop3.tgz
RUN tar -xvzf spark-3.3.1-bin-hadoop3.tgz
RUN rm spark-3.3.1-bin-hadoop3.tgz

RUN sbin/start-master.sh -p PORT_MASTER --webui-port PORT_WEBUI -h 127.0.0.1
RUN sbin/start-worker.sh spark://localhost:PORT_MASTER -m 1G
