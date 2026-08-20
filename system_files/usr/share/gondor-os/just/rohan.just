# Install my personal homebrew packages
rohan-install-brews:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing Homebrews..."
    xargs -a <(curl --retry 3 -sL https://raw.githubusercontent.com/joaosant7/rohan-os/main/repo_files/brews) brew install
    echo "Homebrews installation complete."

# Install my personal flatpaks
rohan-install-flatpaks:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing Flatpaks..."
    xargs -a <(curl --retry 3 -sL https://raw.githubusercontent.com/joaosant7/rohan-os/main/repo_files/flatpaks) flatpak --system -y install
    echo "Flatpaks installation complete."

