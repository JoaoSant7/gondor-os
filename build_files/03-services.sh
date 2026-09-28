#!/bin/bash
set -ouex pipefail

# --- greetd user (UID/GID 955) ---
# Required by /usr/lib/tmpfiles.d/greetd.conf (from greetd package).
GREETD_UID=955
GREETD_GID=955

if ! grep -q "^greetd:" /usr/lib/passwd; then
  echo "greetd:x:${GREETD_UID}:${GREETD_GID}:greetd daemon:/var/lib/greetd:/sbin/nologin" >>/usr/lib/passwd
fi
if ! grep -q "^greetd:" /usr/lib/group; then
  echo "greetd:x:${GREETD_GID}:" >>/usr/lib/group
fi

# greetd home
mkdir -p /var/lib/greetd
chown -R ${GREETD_UID}:${GREETD_GID} /var/lib/greetd
chmod 750 /var/lib/greetd

systemctl enable greetd
systemctl set-default graphical.target
systemctl enable podman.socket
