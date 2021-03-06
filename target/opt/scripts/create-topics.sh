#!/bin/bash

if [[ -z "$KAFKA_CREATE_TOPICS" ]]; then
    echo "No topics to create."
    exit 0
fi

if [[ -z "$START_TIMEOUT" ]]; then
    START_TIMEOUT=600
fi

start_timeout_exceeded=false
count=0
step=10
while netstat -lnt | awk '$4 ~ /:'"9092"'$/ {exit 1}'; do
    echo "waiting for kafka to be ready"
    sleep $step;
    count=$((count + step))
    if [ $count -gt $START_TIMEOUT ]; then
        start_timeout_exceeded=true
        break
    fi
done

if $start_timeout_exceeded; then
    echo "Not able to auto-create topic (waited for $START_TIMEOUT sec)"
    exit 1
fi


# Expected format:
#   name:partitions:replicas:cleanup.policy
IFS="${KAFKA_CREATE_TOPICS_SEPARATOR-,}"; for topicToCreate in $KAFKA_CREATE_TOPICS; do
    if [ ! -z "${topicToCreate// }" ]; then
        echo "creating topics: $topicToCreate"
        IFS=':' read -r -a topicConfig <<< "$topicToCreate"
        config=
        if [ -n "${topicConfig[3]}" ]; then
            config="--config=cleanup.policy=${topicConfig[3]}"
        fi

        COMMAND="JMX_PORT='' ${KAFKA_HOME}/bin/kafka-topics.sh \\
            --create \\
            --bootstrap-server localhost:9092 \\
            --topic ${topicConfig[0]} \\
            --partitions ${topicConfig[1]} \\
            --replication-factor ${topicConfig[2]} \\
            ${config} \\
            --if-not-exists &"
        eval "${COMMAND}"
    fi
done

wait