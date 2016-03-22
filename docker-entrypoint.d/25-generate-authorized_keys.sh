#!/bin/sh

export AUTHORIZED_KEYS=${AUTHORIZED_KEYS:-/var/lib/git/.ssh/authorized_keys}

/go/bin/github_pki
