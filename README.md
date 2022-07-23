# kafka
This is a strimzi based kafka image with enchancements

##Pull

docker pull evdobe/kafka

Latest tag: strimzi-0.27.0-kafka-3.0.0-ev2

##Config environtment variables

### Zookeeper

- ZOOKEEPER_ID : Number (e.g. 1)
- ZOOKEEPER_SERVERS : Servers config string (e.g. 1=zookeeper-1:2888:3888;2=zookeeper-2:2888:3888;3=zookeeper-3:2888:3888)

### Kafka

- KAFKA_BROKER_ID: Number (e.g. 1)
- KAFKA_ADVERTISED_LISTENERS: Advertised listeners config string (e.g. EXTERNAL://kafka-1:29092,INTERNAL://kafka-1:9092)
- KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: Listener security protocol map config string (e.g. EXTERNAL:PLAINTEXT,INTERNAL:PLAINTEXT)
- KAFKA_LISTENERS: Listeners config string (e.g. EXTERNAL://:29092,INTERNAL://:9092)
- KAFKA_INTER_BROKER_LISTENER_NAME: Listener name (e.g. INTERNAL)
- KAFKA_ZOOKEEPER_CONNECT: Zookeeper connect config string (e.g. zookeeper-1:2181,zookeeper-2:2181,zookeeper-3:2181)
- KAFKA_CREATE_TOPICS_SEPARATOR: Topic config separator (e.g. "$$'\n'")
- KAFKA_CREATE_TOPICS: Topics to create on start config string (e.g. my-event-channel:1:1)

* See Kafka and Zookeeper config properties for more details about the above config environtment variables
