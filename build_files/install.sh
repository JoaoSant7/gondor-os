#!/bin/bash
set -ouex pipefail

# apps
dnf5 install -y \
  brave-origin \
  thunar \
  thunar-archive-plugin

# niri
dnf5 install -y \
  greetd \
  niri \
  noctalia \
  noctalia-greeter \
  xdg-desktop-portal-gtk

# hyprland + noctalia (via lionheartp/Hyprland copr meta package)
#dnf5 install -y \
# noctalia-hyprland-meta \
#hyprland-guiutils \
#hyprutils

# functionality
dnf5 install -y \
  fcitx5 \
  file-roller \
  flameshot \
  kanshi \
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
