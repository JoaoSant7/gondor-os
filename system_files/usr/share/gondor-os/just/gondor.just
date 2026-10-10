# Install my personal homebrew packages
gondor-install-brews:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing Homebrews..."
    xargs -a <(curl --retry 3 -sL https://raw.githubusercontent.com/joaosant7/gondor-os/main/repo_files/brews) brew install
    echo "Homebrews installation complete."

# Install my personal flatpaks
gondor-install-flatpaks:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "Installing Flatpaks..."
    xargs -a <(curl --retry 3 -sL https://raw.githubusercontent.com/joaosant7/gondor-os/main/repo_files/flatpaks) flatpak --system -y install
    echo "Flatpaks installation complete."
