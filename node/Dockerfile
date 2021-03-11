ARG NODE_VERSION=14

FROM node:${NODE_VERSION}-buster

RUN apt update
RUN apt install -y ca-certificates curl \
    build-essential gcc g++ \
    tzdata zip unzip vim wget \
    git openssh-client zsh bash net-tools

RUN npm install -g webpack wepack-cli
