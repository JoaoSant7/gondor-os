#!/bin/bash
set -ouex pipefail

# The Fedora SDDM RPM supplies sysusers and tmpfiles rules for /var/lib/sddm.
# Prevent an old, locally enabled greetd from starting after an image upgrade.
# Masking also works when the archived greeter package is not installed.
systemctl mask greetd.service

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
