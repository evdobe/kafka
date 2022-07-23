#!/bin/bash -e
[ -d "/tmp/zookeeper" ] && chown -R kafka:root /tmp/zookeeper
[ ! -d "/tmp/zookeeper" ] && mkdir /tmp/zookeeper && chown -R kafka:root /tmp/zookeeper
echo $ZOOKEEPER_ID > /tmp/zookeeper/myid

TICK_TIME=${ZOOKEEPER_TICK_TIME:-2000}
INIT_LIMIT=${ZOOKEEPER_INIT_LIMIT:-5}
SYNC_LIMIT=${ZOOKEEPER_SYNC_LIMIT:-2}

echo $'\n' >> config/zookeeper.properties
echo "tickTime=$TICK_TIME" >> config/zookeeper.properties
echo "initLimit=$INIT_LIMIT" >> config/zookeeper.properties
echo "syncLimit=$SYNC_LIMIT" >> config/zookeeper.properties

IFS=';' read -r -a array <<< "$ZOOKEEPER_SERVERS"

j=1;
 for server in ${array[@]}; do 
    echo server.$server >> config/zookeeper.properties
    ((j=j+1))
 done 


runuser kafka -c 'sh -c "bin/zookeeper-server-start.sh config/zookeeper.properties"'