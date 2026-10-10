# Archived SDDM and Astronaut

This folder preserves the previous SDDM package installation, pinned Astronaut
theme installer, service setup and build checks, configuration, Typewriter
wallpaper, customization guide, and login-manager switching recipe. These files
are excluded from the active image build.

Noctalia Greeter is active in `build_files` and `system_files`, using the Terra
package already available through the Bazzite base. Its former archive has been
removed because those files are restored in their active locations.

## Restore

From the repository root:

```bash
python3 archive/sddm/restore.py
just build
```

The command copies the archived files to their original active directories,
adds SDDM package and theme installation to the build, selects SDDM after the
Noctalia service setup, and restores `ujust gondor-greeter`. Repeated runs do not
duplicate build steps or recipes. Review the diff, deploy the rebuilt image,
and boot it. For an existing installation with local service overrides, select
SDDM explicitly:

```bash
ujust gondor-greeter sddm
sudo reboot
```

Noctalia remains installed after restoration and can be selected again with
`ujust gondor-greeter noctalia`. Switching affects the next boot without
stopping the current session.

See [the archived customization guide](docs/sddm.md). Configuration and the
wallpaper are preserved under `system_files/etc/sddm*`; the theme's upstream
commit and checksum are preserved in `build_files/01-sddm-theme.sh`.
