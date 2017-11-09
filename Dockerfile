FROM alpine:3.5

# Create nologin users for Kafka and Elasticsearch services
RUN adduser -DH -s /sbin/nologin kafka && \
    adduser -DH -s /sbin/nologin elasticsearch

# Basic setup
RUN apk add --update bash curl openssh openjdk8 && \
    mkdir /opt && \
    rm /var/cache/apk/*

# Kafka setup
RUN curl http://www.us.apache.org/dist/kafka/0.11.0.1/kafka_2.11-0.11.0.1.tgz | tar -xzf - && \
    mv kafka_2.11-0.11.0.1 /opt/kafka && \
    mkdir /tmp/zookeeper && \
    mkdir /tmp/kafka-logs && \
    chown -R kafka:kafka /opt/kafka /tmp/zookeeper /tmp/kafka-logs

# Elasticsearch setup
RUN curl https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.4.tar.gz | tar -xzf - && \
    mv elasticsearch-5.6.4 /opt/elasticsearch && \
    chown -R elasticsearch:elasticsearch /opt/elasticsearch

# Sbt-extras setup
RUN curl -L https://git.io/sbt > /usr/bin/sbt && \
    chmod 0755 /usr/bin/sbt

VOLUME ["/data"]

ENV KAFKA_HOME /opt/kafka
ENV PATH /home:$PATH

WORKDIR /home

ADD start.sh .
ADD config /root/.ssh/config
ADD id_rsa /root/.ssh/id_rsa

RUN chmod a+x start.sh && \
    chmod 0600 /root/.ssh/config && \
    chmod 0600 /root/.ssh/id_rsa

# Kafka server port
EXPOSE 9092

# Zookeeper port
EXPOSE 2181

# Elasticsearch port
EXPOSE 9200

CMD ["start.sh"]

