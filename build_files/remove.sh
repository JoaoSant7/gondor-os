#!/usr/bin/env bash
set -oue pipefail

echo "Removing GNOME leftovers, input methods, and unused services..."

# remove bluefin unnecessary apps
dnf5 remove -y \
  input-remapper \
  nautilus \
  nautilus-extensions \
  orca \
  ptyxis \
  rygel \
  malcontent-control \
  firewall-config \
  nwg-panel \
  fish

# remove gnome desktop
dnf5 remove -y \
  gnome-autoar \
  gnome-color-manager \
  gnome-disk-utility \
  gnome-shell \
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
  gnome-backgrounds \
  desktop-backgrounds-gnome \
  f44-backgrounds-gnome \
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

# remove ibus
dnf5 remove -y \
  ibus \
  ibus-libs \
  ibus-gtk2 \
  ibus-gtk3 \
  ibus-gtk4 \
  ibus-panel \
  ibus-setup \
  ibus-typing-booster \
  ibus-anthy \
  ibus-hangul \
  ibus-libpinyin \
  ibus-m17n \
  ibus-mozc \
  ibus-unikey \
  ibus-chewing

# remove unnecessary clutter
dnf5 remove -y \
  gsound \
  malcontent \
  malcontent-ui-libs \
  papers-libs \
  papers-previewer \
  papers-thumbnailer \
  yelp-libs \
  yelp-xsl

# autoremove orphaned pkgs
dnf5 autoremove -y || true

# remove unnecessary clutter (desktop files)
rm -f /usr/share/applications/documentation.desktop
rm -f /usr/share/applications/discourse.desktop
rm -f /usr/share/applications/system-update.desktop
rm -f /usr/share/applications/org.gnome.tweaks.desktop
rm -f /usr/share/applications/gnome-background-panel.desktop
rm -f /usr/share/applications/gnome-about-panel.desktop
