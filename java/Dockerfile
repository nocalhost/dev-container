ARG JAVA_VERSION=11
ARG JAVA_VERSION=8

FROM openjdk:${JAVA_VERSION}-jdk-buster

ARG USERNAME=nocalhost
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt install -y ca-certificates curl \
           build-essential gcc g++ \
           tzdata zip unzip vim wget \
           git openssh-client zsh bash net-tools tmux sudo wget \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    # install maven
    && curl -LO https://apache.website-solution.net/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.tar.gz \
    && tar -zxvf apache-maven-3.8.1-bin.tar.gz -C /usr/local/lib/ \
    && rm apache-maven-3.8.1-bin.tar.gz

ENV PATH="/usr/local/lib/apache-maven-3.8.1/bin:${PATH}"
    
# update timezone
ENV TZ Asia/Shanghai
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
COPY ./zsh/zsh-in-docker.sh /tmp
RUN chmod +x /tmp/zsh-in-docker.sh && \
    /tmp/zsh-in-docker.sh \
    -a 'SPACESHIP_PROMPT_ADD_NEWLINE="false"' \
    -a 'SPACESHIP_PROMPT_SEPARATE_LINE="false"' \
    -p git \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions \
    -p https://github.com/zsh-users/zsh-history-substring-search \
    -p https://github.com/zsh-users/zsh-syntax-highlighting \
    -p 'history-substring-search' \
    -a 'bindkey "\$terminfo[kcuu1]" history-substring-search-up' \
    -a 'bindkey "\$terminfo[kcud1]" history-substring-search-down'

COPY ./zsh/.p10k.zsh /root

COPY ./zsh/.tmux.conf /root

RUN chsh -s /usr/bin/zsh

ENTRYPOINT [ "/bin/zsh" ]
CMD ["-l"]
