#!/bin/bash
set -ouex pipefail

# Terra is already included in the Bazzite base; no additional repository is needed.

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

# Noctalia desktop shell.
dnf5 install -y noctalia

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

# theming
dnf5 install -y \
  adw-gtk3-theme \
  nwg-look \
  qt6ct

# Select the stable Terra package; dependencies can use the other base repos.
dnf5 install -y --from-repo=terra noctalia-greeter
dnf5 install -y greetd

# Build-time RPM state is replaced by the system_files configuration afterward.
rm -rf /var/lib/greetd/.config

echo "Adding Gondor OS just recipes"
echo "import \"/usr/share/gondor-os/just/gondor.just\"" >>/usr/share/ublue-os/just/60-custom.just
