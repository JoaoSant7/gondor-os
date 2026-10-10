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

# The Fedora SDDM RPM supplies sysusers and tmpfiles rules for /var/lib/sddm.
# Noctalia's /var directories and config link are also created at boot.
# Disable greetd's graphical.target dependency as well as its display-manager
# alias before selecting SDDM. Do not start or stop services during the build.
systemctl disable greetd.service

# Older Bazzite images can mount writable themes over our image-owned assets.
if [[ -f /usr/lib/systemd/system/usr-share-sddm-themes.mount ]]; then
  systemctl disable usr-share-sddm-themes.mount
fi
if [[ -f /usr/lib/systemd/system/bazzite-autologin.service ]]; then
  systemctl disable bazzite-autologin.service
fi
systemctl enable --force sddm.service
systemctl set-default graphical.target
systemctl enable podman.socket

# Fail the image build if cleanup removed a greeter dependency or the /etc
# overlay no longer supplies the editable theme files.
rpm -q sddm sddm-wayland-generic qt6-qtdeclarative qt6-qtwayland \
  qt6-qtsvg qt6-qtvirtualkeyboard qt6-qtmultimedia >/dev/null
test -x /usr/bin/sddm-greeter-qt6
test -x /usr/bin/weston
test -r /usr/lib/sysusers.d/sddm.conf
test -r /usr/lib/tmpfiles.d/sddm.conf
theme_dir=/usr/share/sddm/themes/sddm-astronaut-theme
test -r "$theme_dir/metadata.desktop"
theme_preset=$(sed -n 's/^ConfigFile=//p' "$theme_dir/metadata.desktop")
test -n "$theme_preset"
test -r "$theme_dir/$theme_preset"
test -r "$theme_dir/$theme_preset.user"
