ARG JAVA_VERSION=11

FROM openjdk:${JAVA_VERSION}-jdk-buster

RUN apt update
RUN apt install -y ca-certificates curl \
    build-essential gcc g++ \
    tzdata zip unzip vim wget \
    git openssh-client zsh bash net-tools