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
dnf5 install -y terra-release

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
  adwaita-icon-theme \
  qt6-qtsvg \
  qt6-qtvirtualkeyboard \
  qt6-qtmultimedia \
  nwg-look \
  qt5ct \
  qt6ct

# remove bluefin unecessary apps
dnf5 remove -y \
  gnome-color-manager \
  input-remapper \
  nautilus \
  ptyxis \
  rygel \
  malcontent-control \
  firewall-config \
  nwg-panel \
  fish

# remove gnome desktop
dnf5 remove -y \
  gnome-disks \
  gnome-shell \
  gnome-extensions \
  gnome-session \
  gnome-tour \
  gnome-system-monitor \
  gnome-user-docs \
  gdm \
  gnome-shell-common \
  mutter \
  mutter-common \
  gnome-settings-daemon \
  gnome-control-center \
  gnome-control-center-filesystem \
  gnome-tweaks \
  gnome-color-manager \
  gnome-disk-utility \
  gnome-backgrounds \
  desktop-backgrounds-gnome \
  f44-backgrounds-gnome \
  gnome-user-docs \
  gnome-app-list \
  gnome-menus \
  gnome-user-share \
  gnome-remote-desktop \
  gnome-epub-thumbnailer \
  gnome-online-accounts \
  gnome-online-accounts-libs \
  gnome-bluetooth \
  gnome-bluetooth-libs \
  gweather-locations \
  gweather-locations-common

# remove unecessary clutter
rm -f /usr/share/applications/documentation.desktop
rm -f /usr/share/applications/discourse.desktop
rm -f /usr/share/applications/system-update.desktop
rm -f /usr/share/applications/org.gnome.tweaks.desktop
rm -f /usr/share/applications/gnome-background-panel.desktop
rm -f /usr/share/applications/gnome-about-panel.desktop

sudo systemctl enable greetd
sudo systemctl set-default graphical.target
systemctl enable podman.socket

# === cleanup ===
dnf clean all && rm -rf /var/cache/dnf/*
dnf5 clean all
