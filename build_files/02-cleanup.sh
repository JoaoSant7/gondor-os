#!/bin/bash
set -ouex pipefail

# Remove all KDE Framework 5 libraries (COSMIC has no kf5 deps)
dnf5 remove -y kf5-* || true

# Remove orphaned Qt and other packages no longer required
dnf5 autoremove -y || true

rm -rf /var/lib/dnf/* /var/log/dnf*
rm -rf /run/dnf /run/selinux-policy
rm -rf /var/lib/greetd/.config
rm -rf /tmp/*

dnf5 clean all && rm -rf /var/cache/dnf/*
