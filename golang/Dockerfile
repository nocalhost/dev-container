ARG GO_VERSION=1.16

FROM golang:${GO_VERSION}-buster

RUN apt update
RUN apt install -y ca-certificates curl \
    build-essential gcc g++ \
    tzdata zip unzip vim wget \
    git openssh-client zsh bash net-tools

RUN go get github.com/go-delve/delve/cmd/dlv