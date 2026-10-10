#!/usr/bin/env bash
set -euo pipefail

dnf5 install -y noctalia-greeter greetd

# Build-time RPM state is replaced by the system_files configuration afterward.
rm -rf /var/lib/greetd/.config
