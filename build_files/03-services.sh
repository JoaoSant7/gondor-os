#!/bin/bash
set -ouex pipefail

# Prevent Bazzite autologin from bypassing the configured greeter.
if [[ -f /usr/lib/systemd/system/bazzite-autologin.service ]]; then
  systemctl disable bazzite-autologin.service
fi
systemctl set-default graphical.target
systemctl enable podman.socket
