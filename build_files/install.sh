#!/bin/bash
set -ouex pipefail

# apps
dnf5 install -y \
  brave-origin \
  thunar \
  thunar-archive-plugin

# hyprland
dnf5 install -y \
  greetd \
  noctalia \
  noctalia-greeter \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-hyprland

# hyprland
#dnf5 install -y \
#  hyprland \
#  hyprcursor \
#  hyprland-guiutils \
#  hyprutils \
#  xdg-desktop-portal-hyprland

# functionality
dnf5 install -y \
  fcitx5 \
  file-roller \
  flameshot \
  kde-connect \
  loupe \
  mpv \
  syncthing

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
  qt5ct \
  qt6ct

echo "Adding Gondor OS just recipes"
echo "import \"/usr/share/gondor-os/just/gondor.just\"" >>/usr/share/ublue-os/just/60-custom.just
