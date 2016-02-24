#!/bin/bash
set -e

ln -sf /post-update /var/lib/git/$REPO.git/hooks/
ln -sf /post-update.d /var/lib/git/$REPO.git/hooks/
