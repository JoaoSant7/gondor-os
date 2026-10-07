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
  thunar-archive-plugin

# mango
dnf5 install -y \
  mangowm

# hyprland + noctalia (via lionheartp/Hyprland copr meta package)
dnf5 install -y \
  hyprland \
  hyprland-uwsm \
  hyprland-guiutils \
  hyprutils \
  uwsm \
  xdg-desktop-portal-hyprland

# noctalia
dnf5 install -y \
  greetd \
  noctalia-git \
  noctalia-greeter \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-gnome \
  gnome-keyring \
  gnome-keyring-pam

# functionality
dnf5 install -y \
  file-roller \
  kanshi \
  mpv

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

echo "Adding Gondor OS just recipes"
echo "import \"/usr/share/gondor-os/just/gondor.just\"" >>/usr/share/ublue-os/just/60-custom.just
