#!/bin/bash

if test -n "${RSA_PRIVATE_KEY}"; then
  echo -e "${RSA_PRIVATE_KEY}" > /tmp/id_rsa
  chmod 0600 /tmp/id_rsa
  ssh-keygen -y -f /tmp/id_rsa >> /var/lib/git/.ssh/authorized_keys
  rm -f /tmp/id_rsa
fi

if test -n "${PUBLIC_KEY}"; then
  echo "${PUBLIC_KEY}" >> /var/lib/git/.ssh/authorized_keys
fi
