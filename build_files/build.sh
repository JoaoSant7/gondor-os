#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Third-party repos
dnf5 -y copr enable lionheartp/Hyprland

dnf remove -y \
	thunderbird \
	konsole \
	kate


# this installs a package from fedora repos
#
# general apps
dnf5 install -y \
	tmux \
	kitty

dnf5 install -y \
	hyprland
	noctalia-git

# === cli: Cli packages ===

dnf5 install -y \
    zoxide \
    zsh \
    htop \
    nvim \
    git \
    ripgrep \
    fzf \
    fd \
    bat \
    fastfetch



# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
