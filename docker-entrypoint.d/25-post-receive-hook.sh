#!/bin/bash
set -e

ln -sf /post-receive /var/lib/git/$REPO.git/hooks/
ln -sf /post-receive.d /var/lib/git/$REPO.git/hooks/
