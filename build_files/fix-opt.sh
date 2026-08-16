#!/bin/bash
set -ouex pipefail

# Ensure /opt is a real directory, not the OSTree /var/opt symlink,
# so RPMs that install into /opt/* (like Brave) can unpack cleanly.
if [ -L /opt ]; then
  rm -f /opt
  mkdir -p /opt
fi
