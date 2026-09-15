#!/bin/bash
set -ouex pipefail

# apps
dnf5 install -y \
  brave-origin \
  thunar \
  thunar-archive-plugin \
  zathura \
  zathura-pdf-poppler

# niri
dnf5 install -y \
  greetd \
  niri \
  noctalia \
  noctalia-greeter \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal-gnome \
  gnome-keyring

# hyprland + noctalia (via lionheartp/Hyprland copr meta package)
#dnf5 install -y \
# noctalia-hyprland-meta \
#hyprland-guiutils \
#hyprutils

# functionality
dnf5 install -y \
  fcitx5 \
  file-roller \
  kanshi \
  kde-connect \
  loupe \
  mpv \
  syncthing

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
  qt5ct \
  qt6ct

echo "Adding Gondor OS just recipes"
echo "import \"/usr/share/gondor-os/just/gondor.just\"" >>/usr/share/ublue-os/just/60-custom.just
