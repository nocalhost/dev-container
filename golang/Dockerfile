ARG GO_VERSION=1.15

FROM golang:${GO_VERSION}-alpine

RUN apk add -q --update --progress --no-cache ca-certificates curl \
    build-base gcc g++ \
    tzdata zip unzip vim wget \
    git openssh-client zsh bash net-tools