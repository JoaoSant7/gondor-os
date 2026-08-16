#!/bin/bash
set -ouex pipefail

dnf5 -y copr enable lionheartp/Hyprland
dnf5 install -y terra-release
