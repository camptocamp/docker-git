#!/bin/bash
set -e

mkdir -p /var/lib/git/$REPO.git
chown -R git:git /var/lib/git/$REPO.git
cd /var/lib/git/$REPO.git && git rev-parse --is-bare-repository > /dev/null \
  || su - git -s /bin/bash -c "cd /var/lib/git/$REPO.git && git --bare init"
