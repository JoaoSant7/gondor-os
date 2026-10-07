#!/bin/bash
set -ouex pipefail

# Reuse the package's boot-time account definition when available. A fallback
# also covers packages that create greetd only in an RPM installation script.
# sysusers preserves an existing account and allocates an ID only if missing.
if ! grep -Eq '^[[:space:]]*u[[:space:]]+"?greetd"?[[:space:]]' /usr/lib/sysusers.d/*.conf; then
  install -d -m 0755 /usr/lib/sysusers.d
  cat >/usr/lib/sysusers.d/gondor-greetd.conf <<'EOF'
u greetd - "greetd greeter" /var/lib/greetd /sbin/nologin
EOF
fi

# /var directories and the config link are created at boot by tmpfiles.
systemctl enable greetd
systemctl set-default graphical.target
systemctl enable podman.socket
