#!/usr/bin/env bash
set -euo pipefail

# Update the commit and archive checksum together after reviewing upstream.
# Install assets directly; upstream setup.sh is interactive and changes services.
astronaut_commit=abb3163c724935af888ba5ea9ac0c4f22afd8048
astronaut_sha256=3e7ccde7158b336bb7ea6c69a18cefe27a9c82d6c04c4bef03b5b1519d6ae11c
theme_dir=/usr/share/sddm/themes/sddm-astronaut-theme
source_dir=$(mktemp -d /tmp/sddm-astronaut.XXXXXX)
trap 'rm -rf "$source_dir"' EXIT

curl --fail --location --retry 3 \
  "https://codeload.github.com/Keyitdev/sddm-astronaut-theme/tar.gz/${astronaut_commit}" \
  --output "$source_dir/theme.tar.gz"
printf '%s  %s\n' "$astronaut_sha256" "$source_dir/theme.tar.gz" | sha256sum --check -
tar --extract --gzip --file "$source_dir/theme.tar.gz" \
  --directory "$source_dir" --strip-components=1 --no-same-owner

install -d -m 0755 "$theme_dir" /usr/share/fonts/sddm-astronaut
for asset in Main.qml Components Assets Backgrounds Themes LICENSE; do
  cp -a "$source_dir/$asset" "$theme_dir/"
done
cp -a "$source_dir/Fonts/." /usr/share/fonts/sddm-astronaut/
fc-cache --force /usr/share/fonts/sddm-astronaut

# /usr is immutable after deployment. Keep the preset selector and appearance
# overrides in /etc, which the Containerfile copies from system_files afterward.
ln -sfn /etc/sddm/astronaut/metadata.desktop "$theme_dir/metadata.desktop"
for preset in "$theme_dir"/Themes/*.conf; do
  # SDDM loads ConfigFile, then ConfigFile.user. This also works when selecting
  # a different upstream preset in metadata.desktop.
  ln -sfn /etc/sddm/astronaut/theme.conf.user "$preset.user"
done
printf '%s\n' "$astronaut_commit" >"$theme_dir/UPSTREAM_COMMIT"
