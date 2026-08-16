#!/bin/bash
set -ouex pipefail

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
