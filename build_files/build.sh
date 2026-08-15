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
  sddm \
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

# Clone the theme directly into the image's /usr
git clone -b master --depth 1 \
  https://github.com/Keyitdev/sddm-astronaut-theme.git \
  /usr/share/sddm/themes/sddm-astronaut-theme

# Install the fonts into the image
cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/
fc-cache -f

# Set the theme as default
mkdir -p /etc/sddm.conf.d
cat >/etc/sddm.conf.d/theme.conf <<'EOF'
[Theme]
Current=sddm-astronaut-theme
EOF

cat >/etc/sddm.conf.d/virtualkbd.conf <<'EOF'
[General]
InputMethod=qtvirtualkeyboard
EOF

# Set custom wallpaper to sddm-astronaut-theme
cp /ctx/assets/wallpapers/mountain-above-clouds.jpg \
  /usr/share/sddm/themes/sddm-astronaut-theme/Backgrounds/mountain-above-clouds.jpg

sed -i 's|^Background=.*|Background="Backgrounds/mountain-above-clouds.jpg"|' \
  /usr/share/sddm/themes/sddm-astronaut-theme/Themes/astronaut.conf

systemctl enable podman.socket

# === cleanup ===
dnf clean all && rm -rf /var/cache/dnf/*
dnf5 clean all
