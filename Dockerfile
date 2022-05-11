FROM quay.io/strimzi/kafka:0.27.0-kafka-3.0.0

USER root

COPY target /
RUN chmod ugo+x /opt/scripts/*.sh