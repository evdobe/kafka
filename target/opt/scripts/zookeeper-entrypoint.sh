#!/bin/bash -e
[ -d "/tmp/zookeeper" ] && chown -R kafka:root /tmp/zookeeper
runuser kafka -c 'sh -c "bin/zookeeper-server-start.sh config/zookeeper.properties"'