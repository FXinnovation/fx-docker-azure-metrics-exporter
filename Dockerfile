FROM golang:1.11 as builder

ENV AZURE_METRICS_EXPORTER_VERSION=4411b47ff5c61208b1cbd3e8a1e2d097aabdafa7

WORKDIR /go/src/github.com/RobustPerception/azure_metrics_exporter

RUN git clone https://github.com/RobustPerception/azure_metrics_exporter.git . &&\
    git checkout ${AZURE_METRICS_EXPORTER_VERSION} &&\
    make build

FROM alpine:3.9

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

ENV CA_CERTIFICATES_VERSION=20190108-r0 \
    RESOURCE_MANAGER_URL=https://change.me.com \
    ACTIVE_DIRECTORY_AUTHORITY_URL=https://change.me.com \
    SUBSCRIPTION_ID=apekeii-eaee \
    CLIENT_ID=iqpjdpqjiwdm \
    CLIENT_SECRET=kdwokdqjdqkpqkdqo \
    TENANT_ID=kdqqojdwdqp \
    AZURE_RESOURCE_ID=jdqojdqodwqdijd \
    AZURE_METRICS_EXPORTER_VERSION=4411b47ff5c61208b1cbd3e8a1e2d097aabdafa7 \
    METRICS_NAME=memory \
    RESOURCE_TAG_NAME=tagname \
    RESOURCE_TAGS_METRICS_NAME=metricsname \
    RESOURCE_GROUPS_TARGETS_METRICS_NAME=targetsmetricsname 

ADD ./resources /resources

COPY --from=builder /go/src/github.com/RobustPerception/azure_metrics_exporter/azure_metrics_exporter /resources/azure_metrics_exporter

VOLUME /opt/azure_metrics_exporter/conf

RUN /resources/build && rm -rf /resources

EXPOSE 9276

USER exporter

ENTRYPOINT ["/opt/azure_metrics_exporter/azure_metrics_exporter", "--config.file='/opt/azure_metrics_exporter/conf/azure.yml'"]


LABEL "maintainer"="cloudsquad@fxinnovation.com" \
      "org.label-schema.name"="azure-metrics-exporter" \
      "org.label-schema.base-image.name"="docker.io/library/alpine" \
      "org.label-schema.base-image.version"="3.9" \
      "org.label-schema.applications.azure-metrics-exporter.version"=${AZURE_METRICS_EXPORTER_VERSION} \
      "org.label-schema.applications.ca-certificate.version"=${CA_CERTIFICATES_VERSION} \
      "org.label-schema.description"="azure exporter in a container" \
      "org.label-schema.url"="https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/docker-azure-metrics-exporter" \
      "org.label-schema.vcs-url"="https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/docker-azure-metrics-exporter" \
      "org.label-schema.vendor"="FXinnovation" \
      "org.label-schema.schema-version"="1.0.0-rc.1" \
      "org.label-schema.vcs-ref"=$VCS_REF \
      "org.label-schema.version"=$VERSION \
      "org.label-schema.build-date"=$BUILD_DATE
