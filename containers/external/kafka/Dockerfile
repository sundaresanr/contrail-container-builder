ARG CONTRAIL_REGISTRY
ARG CONTRAIL_CONTAINER_TAG
FROM ${CONTRAIL_REGISTRY}/contrail-general-base:${CONTRAIL_CONTAINER_TAG}

ARG CONTAINER_NAME
ARG KAFKA_DISTRO_NAME=kafka_2.11-0.9.0.1

ENV KAFKA_DIR=/opt/$KAFKA_DISTRO_NAME \
    KAFKA_CONF_DIR=/opt/$KAFKA_DISTRO_NAME/config

RUN yum install -y java iproute && \
    curl -o $KAFKA_DISTRO_NAME.tgz http://archive.apache.org/dist/kafka/0.9.0.1/$KAFKA_DISTRO_NAME.tgz && \
    tar -xvf $KAFKA_DISTRO_NAME.tgz && \
    mv $KAFKA_DISTRO_NAME /opt/$KAFKA_DISTRO_NAME && \
    rm -f $KAFKA_DISTRO_NAME.tgz && \
    yum clean all -y && \
    rm -rf /var/cache/yum

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
WORKDIR /opt/$KAFKA_DISTRO_NAME
CMD ["bin/kafka-server-start.sh", "config/server.properties"]

LABEL net.juniper.contrail.service=kafka
LABEL net.juniper.contrail.container.name=$CONTAINER_NAME
