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
  hyprland \
  hyprcursor \
  hyprland-guiutils \
  hyprutils \
  noctalia \
  noctalia-greeter \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-hyprland

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
  eza \
  fastfetch \
  fd-find \
  fzf \
  kitty \
  git \
  htop \
  neovim \
  ripgrep \
  tmux \
  zoxide \
  zsh

# theming
dnf5 install -y \
  adw-gtk3-theme \
  nwg-look \
  qt5ct \
  qt6ct

log "Adding Rohan OS just recipes"
echo "import \"/usr/share/rohanos/just/rohan.just\"" >>/usr/share/ublue-os/justfile
