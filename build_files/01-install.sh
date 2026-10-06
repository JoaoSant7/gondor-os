#!/bin/bash
set -ouex pipefail

dnf5 -y copr enable lionheartp/Hyprland
#dnf5 install -y terra-release

# apps
dnf5 install -y \
  brave-origin \
  thunar \
  thunar-archive-plugin

# apps
dnf5 install -y \
  niri

# noctalia
dnf5 install -y \
  greetd \
  noctalia-git \
  noctalia-greeter \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-gnome \
  gnome-keyring \
  gnome-keyring-pam

# hyprland + noctalia (via lionheartp/Hyprland copr meta package)
dnf5 install -y \
  hyprland \
  hyprland-uwsm \
  hyprland-guiutils \
  hyprutils \
  uwsm \
  xdg-desktop-portal-hyprland

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
