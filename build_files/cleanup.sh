#!/bin/bash
set -ouex pipefail

dnf5 clean all
rm -rf /var/lib/dnf/* /var/log/dnf*
rm -rf /run/dnf /run/selinux-policy
rm -rf /var/lib/greetd/.config
rm -rf /tmp/*
ostree container commit
