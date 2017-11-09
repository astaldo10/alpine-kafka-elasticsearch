#!/bin/bash

# Init Zookeeper and Kafka on background
su -s "/bin/bash" -c "/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties" kafka &
su -s "/bin/bash" -c "/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties" kafka &

# Init Elasticsearch server
su -s /opt/elasticsearch/bin/elasticsearch elasticsearch

