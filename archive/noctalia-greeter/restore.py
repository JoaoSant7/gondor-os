#!/usr/bin/env python3
"""Restore the archived Noctalia greeter integration to this repository."""

from pathlib import Path
import shutil


def main():
    archive = Path(__file__).resolve().parent
    repo = archive.parent.parent
    containerfile = repo / "Containerfile"
    installer = repo / "build_files/01-install.sh"
    recipes = repo / "system_files/usr/share/gondor-os/just/gondor.just"

    container_text = containerfile.read_text()
    service_step = "    bash /ctx/03-services.sh && \\\n"
    archived_step = "    bash /ctx/04-noctalia-greeter.sh && \\\n"
    if archived_step not in container_text:
        if container_text.count(service_step) != 1:
            raise SystemExit("Cannot locate the service build step in Containerfile.")
        container_text = container_text.replace(service_step, service_step + archived_step)

    install_text = installer.read_text()
    install_step = "bash /ctx/01-noctalia-greeter.sh"
    if install_step not in install_text:
        install_text = install_text.rstrip() + "\n\n# Restore the archived Noctalia greeter.\n" + install_step + "\n"

    recipe_text = recipes.read_text()
    if "gondor-greeter greeter:" not in recipe_text:
        recipe_text = recipe_text.rstrip() + "\n\n" + (archive / "gondor-greeter.just").read_text()

    # Restore only greeter-specific files; preserve unrelated image settings.
    for source_root, target_root in [
        (archive / "system_files", repo / "system_files"),
        (archive / "build_files", repo / "build_files"),
    ]:
        for source in source_root.rglob("*"):
            if source.is_file():
                target = target_root / source.relative_to(source_root)
                target.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(source, target)

    installer.write_text(install_text)
    containerfile.write_text(container_text)
    recipes.write_text(recipe_text)
    print("Noctalia greeter restored to the repository. Rebuild and deploy the image.")
    print("After booting it, run: ujust gondor-greeter noctalia, then reboot.")


if __name__ == "__main__":
    main()
