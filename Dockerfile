FROM golang:1.11 as builder
WORKDIR /go/src/github.com/RobustPerception/azure_metrics_exporter
git clone https://github.com/RobustPerception/azure_metrics_exporter/blob/master/
RUN make build

FROM alpine:3.9 AS app

COPY --from=builder /go/src/github.com/RobustPerception/azure_metrics_exporter/azure_metrics_exporter /bin/azure_metrics_exporter

ca.cert

EXPOSE 9276
ENTRYPOINT ["/bin/azure_metrics_exporter"]