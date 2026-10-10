#!/usr/bin/env python3
"""Restore the archived SDDM and Astronaut integration to this repository."""

from pathlib import Path
import shutil


def main():
    archive = Path(__file__).resolve().parent
    repo = archive.parent.parent
    containerfile = repo / "Containerfile"
    installer = repo / "build_files/01-install.sh"
    recipes = repo / "system_files/usr/share/gondor-os/just/gondor.just"

    container_text = containerfile.read_text()
    for anchor, step in [
        ("    bash /ctx/01-install.sh && \\\n", "    bash /ctx/01-sddm-theme.sh && \\\n"),
        ("    bash /ctx/04-noctalia-greeter.sh && \\\n", "    bash /ctx/04-sddm.sh && \\\n"),
    ]:
        if step not in container_text:
            if container_text.count(anchor) != 1:
                raise SystemExit(f"Cannot locate the build step: {anchor.strip()}")
            container_text = container_text.replace(anchor, anchor + step)

    install_text = installer.read_text()
    install_step = "bash /ctx/01-sddm-install.sh"
    if install_step not in install_text:
        install_text = install_text.rstrip() + "\n\n# Restore the archived SDDM greeter.\n" + install_step + "\n"

    recipe_text = recipes.read_text()
    if "gondor-greeter greeter:" not in recipe_text:
        recipe_text = recipe_text.rstrip() + "\n\n" + (archive / "gondor-greeter.just").read_text()

    for category in ["system_files", "build_files", "docs"]:
        for source in (archive / category).rglob("*"):
            if source.is_file():
                target = repo / category / source.relative_to(archive / category)
                target.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(source, target)

    installer.write_text(install_text)
    containerfile.write_text(container_text)
    recipes.write_text(recipe_text)
    print("SDDM and Astronaut restored to the repository. Rebuild and deploy the image.")
    print("After booting it, run: ujust gondor-greeter sddm, then reboot.")


if __name__ == "__main__":
    main()
