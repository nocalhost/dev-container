ARG PYTHON_VERSION=3.9

FROM python:${PYTHON_VERSION}-buster

RUN apt update
RUN apt install -y ca-certificates curl \
    build-essential gcc g++ \
    tzdata zip unzip vim wget \
    git openssh-client zsh bash net-tools