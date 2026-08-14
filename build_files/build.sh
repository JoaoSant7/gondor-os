#!/bin/bash

set -ouex pipefail

# Copy local overlay files to root /
cp -avf "/ctx/system_files"/. /

# Ensure /opt is a real directory, not the OSTree /var/opt symlink,
# so RPMs that install into /opt/* (like Brave) can unpack cleanly.
if [ -L /opt ]; then
  rm -f /opt
  mkdir -p /opt
fi

### Enable third party repos
dnf5 -y copr enable lionheartp/Hyprland

curl -fsSL https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo \
  -o /etc/yum.repos.d/terra.repo
dnf5 install -y terra-release

curl -fsSLo /etc/yum.repos.d/brave-browser.repo \
  https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

# remove bluefin unecessary apps
dnf5 remove -y \
  input-remapper \
  nautilus \
  ptyxis \
  rygel \
  malcontent-control \
  firewall-config

# remove gnome desktop
dnf5 remove -y \
  gnome-shell \
  gnome- extensions \
  gnome-session \
  gnome-tour \
  gnome-system-monitor \
  gdm

# remove unecessary clutter
rm -f /usr/share/applications/documentation.desktop
rm -f /usr/share/applications/discourse.desktop
rm -f /usr/share/applications/system-update.desktop
rm -f /usr/share/applications/org.gnome.tweaks.desktop
rm -f /usr/share/applications/gnome-background-panel.desktop
rm -f /usr/share/applications/gnome-about-panel.desktop

# apps
dnf5 install -y \
  brave-origin \
  thunar

# hyprland
dnf5 install -y \
  hyprland \
  hyprutils \
  noctalia \
  nwg-look \
  qt5ct \
  qt6ct \
  sddm \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-hyprland

# functionality
dnf5 install -y \
  fcitx5 \
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
  ghostty \
  git \
  htop \
  neovim \
  ripgrep \
  tmux \
  zoxide \
  zsh

# theming
dnf5 install -y \
  adwaita-icon-theme

systemctl enable podman.socket

# === cleanup ===
dnf clean all && rm -rf /var/cache/dnf/*
dnf5 clean all
