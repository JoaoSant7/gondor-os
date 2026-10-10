# Select the login manager for the next boot without interrupting this session.
gondor-greeter greeter:
    #!/usr/bin/env bash
    set -euo pipefail

    case "{{ greeter }}" in
      sddm)
        sudo systemctl disable greetd.service
        sudo systemctl enable --force sddm.service
        ;;
      noctalia)
        sudo systemctl unmask greetd.service
        sudo systemctl disable sddm.service
        sudo systemctl enable --force greetd.service
        ;;
      *)
        echo "Usage: ujust gondor-greeter sddm|noctalia" >&2
        exit 2
        ;;
    esac
    echo "Login manager selected. Reboot to apply."
