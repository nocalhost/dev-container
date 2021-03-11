ARG RUBY_VERSION=3.0

FROM ruby:${RUBY_VERSION}-buster

RUN apt update
RUN apt install -y ca-certificates curl \
    build-essential gcc g++ \
    tzdata zip unzip vim wget \
    git openssh-client zsh bash net-tools