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

# niri
dnf5 install -y \
  niri

# hyprland + noctalia (via lionheartp/Hyprland copr)
dnf5 install -y \
  hyprland \
  hyprland-uwsm \
  hyprland-guiutils \
  hyprutils \
  uwsm

# noctalia
dnf5 install -y \
  noctalia-git \
  noctalia-greeter

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
dnf5 install -y \
  greetd

# theming
dnf5 install -y \
  adw-gtk3-theme \
  nwg-look \
  qt6ct

# portals
dnf5 install -y \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-gnome \
  xdg-desktop-portal-kde \
  xdg-desktop-portal-hyprland

echo "Adding Gondor OS just recipes"
echo "import \"/usr/share/gondor-os/just/gondor.just\"" >>/usr/share/ublue-os/just/60-custom.just
