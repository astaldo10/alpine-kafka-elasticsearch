#!/bin/bash

# Init Zookeeper and Kafka on background
su -s "/bin/bash" -c "/opt/kafka/bin/zookeeper-server-start.sh /opt/kafka/config/zookeeper.properties" kafka &
su -s "/bin/bash" -c "/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties" kafka &

# Wait 5 seconds to (hopefully) let start the servers
sleep 5

# Create the testing topics
/opt/kafka/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic source.blueliv.1
/opt/kafka/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic cp.detections

# Init Elasticsearch server
su -s /opt/elasticsearch/bin/elasticsearch elasticsearch

