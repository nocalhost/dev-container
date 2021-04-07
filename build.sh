#!/bin/sh
set -e

docker build -f ./golang/Dockerfile . -t golang --no-cache
docker build -f ./java/Dockerfile . -t java --no-cache
docker build -f ./node/Dockerfile . -t node --no-cache
docker build -f ./python/Dockerfile . -t python --no-cache
docker build -f ./ruby/Dockerfile . -t ruby --no-cache