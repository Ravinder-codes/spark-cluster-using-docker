FROM python:3.10-slim-bullseye

USER root

WORKDIR /app

RUN apt-get update && \
    apt-get install --no-install-recommends -y openjdk-17-jdk wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Spark setup
RUN mkdir /spark && \
    wget -O /tmp/spark.tgz https://dlcdn.apache.org/spark/spark-4.1.1/spark-4.1.1-bin-hadoop3.tgz && \
    tar -xzf /tmp/spark.tgz -C /spark && \
    rm /tmp/spark.tgz

RUN apt-get update && \
    apt-get -y install procps

ENV JAVA_HOME='/usr/lib/jvm/java-17-openjdk-amd64'
ENV SPARK_HOME='/spark/spark-4.1.1-bin-hadoop3'
ENV PATH=${JAVA_HOME}/bin:${SPARK_HOME}/bin:${SPARK_HOME}/sbin:$PATH
