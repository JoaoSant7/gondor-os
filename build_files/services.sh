#!/bin/bash
set -ouex pipefail

systemctl enable greetd
systemctl set-default graphical.target
systemctl enable podman.socket
