#!/bin/bash -e
[ -d "/tmp/kafka-logs" ] && chown -R kafka:root /tmp/kafka-logs
rm /tmp/kafka-logs/.lock | true
runuser kafka -c '/opt/kafka/bin/kafka-server-start.sh config/server.properties --override listener.security.protocol.map=$KAFKA_LISTENER_SECURITY_PROTOCOL_MAP --override listeners=$KAFKA_LISTENERS --override advertised.listeners=$KAFKA_ADVERTISED_LISTENERS --override zookeeper.connect=$KAFKA_ZOOKEEPER_CONNECT &
/opt/scripts/create-topics.sh'
tail -f /dev/null
