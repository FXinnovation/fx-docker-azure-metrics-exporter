# docker-azure-metrics-exporter
[![](https://images.microbadger.com/badges/version/fxinnovation/azure_metrics_exporter.svg)](https://microbadger.com/images/fxinnovation/azure_metrics_exporter "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/fxinnovation/azure_metrics_exporter.svg)](https://microbadger.com/images/fxinnovation/azure_metrics_exporter "Get your own image badge on microbadger.com")
[azure_metrics_exporter](https://github.com/RobustPerception/azure_metrics_exporter) in a container.

## Usage
```
  docker run \
    -v <PATH-TO-CONFIG>:/opt/azure_metrics_exporter/conf \
    -p 9276:9276 \
    fxinnovation/azure_metrics_exporter:<TAG>
```

## Tags
We do NOT push a `latest` tag for this image. You should always pin a specific version for it.
We do not follow the confd release tags in the docker image tags. You can always find the confd version in the Dockerfile that was used to create the image or you can use the labels of the image.

## Labels
We set labels on our images with additional information on the image. we follow the guidelines defined at http://label-schema.org/. Visit their website for more information about those labels.

## Comments & Issues
If you have comments or detect an issue, please be advised we don't check the docker hub comments. You can always contact us through the repository.
