#!/bin/bash
set -ouex pipefail

#dnf5 install -y terra-release
dnf5 -y copr enable lionheartp/Hyprland

# Exclude Kitty and its subpackages from this COPR.
dnf5 config-manager setopt \
  'copr:copr.fedorainfracloud.org:lionheartp:Hyprland.excludepkgs=kitty*'

# apps
dnf5 install -y \
  brave-origin \
  thunar \
  thunar-archive-plugin \
  thunar-volman

# niri
dnf5 install -y \
  niri \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-gnome

# hyprland (via lionheartp/Hyprland copr)
#dnf5 install -y \
#  hyprland \
#  hyprland-uwsm \
#  hyprland-guiutils \
#  hyprutils \
#  uwsm \
#  xdg-desktop-portal-hyprland

# Noctalia desktop shell (the greeter is archived separately).
dnf5 install -y noctalia-git

# functionality
dnf5 install -y \
  file-roller \
  kanshi \
  gnome-keyring \
  gnome-keyring-pam

# screenshot
dnf5 install -y \
  grim \
  slurp \
  satty

# cli
dnf5 install -y \
  kitty \
  git \
  neovim \
  tmux \
  zsh

# greeter
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

# theming
dnf5 install -y \
  adw-gtk3-theme \
  nwg-look \
  qt6ct

echo "Adding Gondor OS just recipes"
echo "import \"/usr/share/gondor-os/just/gondor.just\"" >>/usr/share/ublue-os/just/60-custom.just
