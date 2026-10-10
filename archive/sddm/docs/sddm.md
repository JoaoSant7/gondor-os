# SDDM customization and use

SDDM with Astronaut is archived under `archive/sddm` and excluded from the
active image. Before following this guide, run
`python3 archive/sddm/restore.py` from the repository root, then rebuild and
deploy the image. Restoration selects SDDM as the default and keeps Noctalia
installed.

## Configuration

| Repository file | Purpose |
| --- | --- |
| `system_files/etc/sddm.conf` | Backend, keyboard, theme, user list, and autologin |
| `system_files/etc/sddm/astronaut/metadata.desktop` | Astronaut preset selector |
| `system_files/etc/sddm/astronaut/theme.conf.user` | Appearance overrides |

After restoring the archive, edit these files and rebuild for image defaults,
or edit their installed `/etc`
paths with administrator privileges. Keep files root-owned and readable (0644).
Local `/etc` edits survive bootc updates and can override new image defaults.

## Appearance

Select a preset in `metadata.desktop`, for example:

```ini
ConfigFile=Themes/black_hole.conf
```

Available presets are in `/usr/share/sddm/themes/sddm-astronaut-theme/Themes/`.
Set appearance overrides in `theme.conf.user`, for example:

```ini
[General]
Font="Open Sans"
FontSize="13"
RoundCorners="20"
FormPosition="center"
HideVirtualKeyboard="true"
```

Comment out a key to inherit its preset value; empty overrides are ignored.
For a custom wallpaper, add `system_files/etc/sddm/astronaut/background.png`
and set `Background="file:///etc/sddm/astronaut/background.png"`. Animated
backgrounds need codecs supported by the installed multimedia backend.

## Preview and use

Preview changes inside your desktop:

```bash
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/sddm-astronaut-theme
```

Reboot to apply changes to the login screen. Select your desktop in the session
picker; SDDM remembers the last user and session. To inspect login problems:

```bash
journalctl -b -u sddm.service
```

Switch to SDDM for the next boot, then reboot:

```bash
ujust gondor-greeter sddm
sudo reboot
```
