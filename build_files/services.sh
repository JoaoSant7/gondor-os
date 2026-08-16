#!/bin/bash
set -ouex pipefail

# --- greetd user (UID/GID 955) ---
# Required by /usr/lib/tmpfiles.d/greetd.conf (from greetd package).
GREETD_UID=955
GREETD_GID=955

# greetd home
mkdir -p /var/lib/greetd
chown -R ${GREETD_UID}:${GREETD_GID} /var/lib/greetd
chmod 750 /var/lib/greetd

systemctl enable greetd
systemctl set-default graphical.target
systemctl enable podman.socket
