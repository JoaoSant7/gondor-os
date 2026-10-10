#!/usr/bin/env bash
set -euo pipefail

# Archived SDDM greeter packages
# Use Fedora's generic Wayland backend: KWin is removed from this image.
# Astronaut uses Qt 6 Quick, SVG, multimedia, and virtual keyboard modules.
dnf5 install -y \
  sddm \
  sddm-wayland-generic \
  qt6-qtdeclarative \
  qt6-qtwayland \
  qt6-qtsvg \
  qt6-qtvirtualkeyboard \
  qt6-qtmultimedia
