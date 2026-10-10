#!/usr/bin/env bash
set -euo pipefail

# Reuse a packaged boot-time account definition, or supply the original fallback.
if ! grep -Eq '^[[:space:]]*u[[:space:]]+"?greetd"?[[:space:]]' /usr/lib/sysusers.d/*.conf; then
  install -d -m 0755 /usr/lib/sysusers.d
  cat >/usr/lib/sysusers.d/gondor-greetd.conf <<'EOF'
u greetd - "greetd greeter" /var/lib/greetd /sbin/nologin
EOF
fi

systemctl unmask greetd.service
systemctl disable sddm.service
systemctl enable --force greetd.service
