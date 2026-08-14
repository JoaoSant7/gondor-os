#!/bin/bash

set -ouex pipefail

# Copy local overlay files to root /
cp -avf "/ctx/system_files"/. /

### Enable COPR Repositories
dnf5 -y copr enable lionheartp/Hyprland

### Enable Terra Repo
curl -fsSL https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo \
  -o /etc/yum.repos.d/terra.repo
dnf5 install -y terra-release

# remove bluefin unecessary apps
dnf5 remove -y \
  input-remapper \
  nautilus \
  ptyxis

# apps
dnf5 install -y \
  thunar

# hyprland
dnf5 install -y \
  hyprland \
  hyprutils \
  nwg-look \
  qt5ct \
  qt6ct \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal-gtk \
  noctalia-git

# cli
dnf5 install -y \
  eza \
  tmux \
  kitty \
  zoxide \
  zsh \
  htop \
  neovim \
  git \
  ripgrep \
  fzf \
  fd-find \
  fastfetch

# remove unecessary clutter
rm -f /usr/share/applications/documentation.desktop
rm -f /usr/share/applications/discourse.desktop

systemctl enable podman.socket

# === cleanup ===
dnf clean all && rm -rf /var/cache/dnf/*
dnf5 clean all
