FROM golang:1.11 as builder
WORKDIR /go/src/github.com/RobustPerception/azure_metrics_exporter
RUN git clone https://github.com/RobustPerception/azure_metrics_exporter.git .
RUN make build

ENV CA_CERTIFICATES_VERSION=20190108-r0

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

FROM alpine:3.9 AS app

COPY --from=builder /go/src/github.com/RobustPerception/azure_metrics_exporter/azure_metrics_exporter /bin/azure_metrics_exporter


EXPOSE 9276
ENTRYPOINT ["/bin/azure_metrics_exporter"]

LABEL "maintainer"="cloudsquad@fxinnovation.com" \
      "org.label-schema.name"="azure-exporter" \
      "org.label-schema.base-image.name"="docker.io/library/alpine" \
      "org.label-schema.base-image.version"="3.9" \
      "org.label-schema.applications.keycloak-gatekeeper.version"=${KEYCLOAK_GATEKEEPER_VERSION} \
      "org.label-schema.applications.ca-certificates.version"=${CA_CERTIFICATES_VERSION} \
      "org.label-schema.description"="azure exporter in a container" \
      "org.label-schema.url"="https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/docker-azure-metrics-exporter" \
      "org.label-schema.vcs-url"="https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/docker-azure-metrics-exporter" \
      "org.label-schema.vendor"="FXinnovation" \
      "org.label-schema.schema-version"="1.0.0-rc.1" \
      "org.label-schema.vcs-ref"=$VCS_REF \
      "org.label-schema.version"=$VERSION \
      "org.label-schema.build-date"=$BUILD_DATE \
      #"org.label-schema.usage"="docker run -v [PATH_TO_CONFIG]:/opt/keycloak/gatekeeper/conf.d fxinnovation/keycloak-gatekeeper:${VERSION}"