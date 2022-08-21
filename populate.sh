#!/bin/bash

docker tag joxit/docker-registry-ui:latest localhost:10102/joxit/docker-registry-ui:latest
docker tag joxit/docker-registry-ui:latest localhost:10102/joxit/docker-registry-ui:2.2
docker tag joxit/docker-registry-ui:latest localhost:10102/joxit/docker-registry-ui:2.2.1
docker tag joxit/docker-registry-ui:latest localhost:10102/joxit/docker-registry-ui:2.2.1-latest
docker tag joxit/docker-registry-ui:latest localhost:10102/joxit/docker-registry-ui:2.2-latest

docker push localhost:10102/joxit/docker-registry-ui:latest
docker push localhost:10102/joxit/docker-registry-ui:2.2
docker push localhost:10102/joxit/docker-registry-ui:2.2.1
docker push localhost:10102/joxit/docker-registry-ui:2.2.1-latest
docker push localhost:10102/joxit/docker-registry-ui:2.2-latest
