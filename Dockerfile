FROM debian:jessie

MAINTAINER mickael.canevet@camptocamp.com

# Install and configure openssh-server
RUN apt-get update \
  && apt-get install -y openssh-server git ruby \
  && rm -f /etc/ssh/ssh_host_*_key* \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/run/sshd /etc/ssh/ssh_host_keys \
  && sed -i -e 's@/etc/ssh/ssh_host@/etc/ssh/ssh_host_keys/ssh_host@g' /etc/ssh/sshd_config

# Configure git user
RUN useradd -r -s /usr/bin/git-shell -d /var/lib/git git \
  && mkdir -p /var/lib/git/.ssh \
  && chown -R git.git /var/lib/git

# Configure git hook
COPY post-receive /
ONBUILD COPY post-receive.d /post-receive.d
COPY post-update /
ONBUILD COPY post-update.d /post-update.d

# Define VOLUMES
VOLUME ["/var/lib/git", "/etc/ssh/ssh_host_keys"]

# github_pki
ENV GOPATH=/go
RUN apt-get update && apt-get install -y golang-go \
  && go get github.com/camptocamp/github_pki \
  && apt-get autoremove -y golang-go \
  && rm -rf /var/lib/apt/lists/*

# Configure entrypoint and command
COPY docker-entrypoint.sh /
COPY docker-entrypoint.d /docker-entrypoint.d
ONBUILD COPY docker-entrypoint.d /docker-entrypoint.d
ENTRYPOINT ["/docker-entrypoint.sh", "/usr/sbin/sshd", "-D"]
