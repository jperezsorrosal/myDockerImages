FROM java8

ENV DEBIAN_FRONTEND noninteractive
ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 0.9.0.1
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"
ENV KAFKA_PACKAGE kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz


# supervisor installation

RUN apt-get update && apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# Zookeeper & Kafka install

RUN apt-get update && \
    apt-get install -y zookeeper wget supervisor dnsutils && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    wget -q http://www-eu.apache.org/dist/kafka/"$KAFKA_VERSION"/"$KAFKA_PACKAGE" -O /tmp/"$KAFKA_PACKAGE" && \
    tar xfz /tmp/"$KAFKA_PACKAGE" -C /opt && \
    rm /tmp/$KAFKA_PACKAGE

RUN mkdir -p /var/lib/zookeeper

EXPOSE 2181 9092

CMD ["/usr/bin/supervisord"]

