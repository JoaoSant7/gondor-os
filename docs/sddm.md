# SDDM on Gondor OS

SDDM is the default login manager for new images. Noctalia and greetd remain
installed so the choice can be reversed. This integration uses Fedora's
`sddm-wayland-generic` package and Weston for the login screen; the selected
desktop session still runs its own compositor. KWin and Plasma are not required.

## Research and design

The following upstream implementations were inspected on 2026-10-10:

| Project | Pattern relevant to this image |
| --- | --- |
| [Bazzite Containerfile](https://github.com/ublue-os/bazzite/blob/7f903b94e31461c92b93110a2cb3a33f9539942a/Containerfile) | Installs SDDM and enables its service during the image build. This is Gondor's actual base. |
| [hypr-blue services](https://github.com/emerli/hypr-blue/blob/e9d06154195a18015e126f63318226a8973b4d9c/build_files/services.sh) | Enables `sddm.service` and selects `graphical.target` in a Fedora Atomic image. |
| [atomic-hyprland theme settings](https://github.com/oameye/atomic-hyprland/blob/28473e0556df5d594cf3d6ef013669a3a1086510/files/etc/sddm.conf.d/theme.conf) | Ships the SDDM theme choice declaratively in `/etc`. Its automatic login policy is not used here. |
| [kde-bootc Containerfile](https://github.com/sigulete/kde-bootc/blob/b513636884eac227c3ba4ffac84d68ea3116d48d/Containerfile) | Installs the full KDE environment on Fedora bootc, then copies administrator configuration after package operations. Gondor only needs the greeter dependencies. |

[Fedora's SDDM package](https://src.fedoraproject.org/rpms/sddm/blob/f43/f/sddm.spec)
builds the greeter against Qt 6 and ships sysusers/tmpfiles definitions for the
`sddm` account and `/var/lib/sddm`. Its
[generic Wayland subpackage](https://packages.fedoraproject.org/pkgs/sddm/sddm-wayland-generic/)
requires Weston. Installing it explicitly avoids relying on a removed Plasma
compositor or a package solver's implicit display-server choice.

[Astronaut upstream](https://github.com/Keyitdev/sddm-astronaut-theme/tree/abb3163c724935af888ba5ea9ac0c4f22afd8048)
requires SDDM 0.21 or later and Qt 6.8 or later, including SVG, virtual keyboard,
and multimedia support. The image explicitly installs the Fedora Qt packages,
including Qt Quick and Wayland. The source archive is pinned by commit and
SHA-256 in `build_files/01-sddm-theme.sh`; no upstream installer is executed.
Only runtime assets and the license are copied, and fonts are installed
system-wide. Update both pins together when upgrading the theme.

SDDM's [theme loader](https://github.com/sddm/sddm/blob/v0.21.0/src/common/ThemeConfig.cpp)
loads the preset named by `ConfigFile` and then its `.user` override. Gondor
links `metadata.desktop` and every `Themes/*.conf.user` to administrator-owned
files in `/etc/sddm/astronaut`. Presets and QML stay image-owned under `/usr`;
appearance settings stay editable without a writable theme mount or boot-time
asset copying. This also keeps future theme code updates attached to the image.

The image disables greetd before enabling SDDM with `--force`, which replaces
the `display-manager.service` alias. It also disables inherited Bazzite
autologin and, when present, the legacy writable SDDM theme mount. The managed
`/etc/sddm.conf` is loaded after all drop-ins and explicitly clears inherited
autologin settings. The image keeps Fedora's PAM and SELinux policies.

## Customize the login screen

| Repository file | Installed path |
| --- | --- |
| `system_files/etc/sddm.conf` | `/etc/sddm.conf` |
| `system_files/etc/sddm/astronaut/metadata.desktop` | `/etc/sddm/astronaut/metadata.desktop` |
| `system_files/etc/sddm/astronaut/theme.conf.user` | `/etc/sddm/astronaut/theme.conf.user` |

Edit repository files and rebuild for image defaults, or edit the installed
files with administrator privileges for a particular machine. The files must
remain readable by the `sddm` user; use root ownership and mode 0644. Local
`/etc` changes survive bootc upgrades, so check for existing overrides when an
image change does not appear.

To choose another preset, change `ConfigFile` in `metadata.desktop`. Shipped
presets are `astronaut`, `black_hole`, `cyberpunk`, `hyprland_kath`,
`jake_the_dog`, `japanese_aesthetic`, `pixel_sakura`, `pixel_sakura_static`,
`post-apocalyptic_hacker`, and `purple_leaves`; use `Themes/<name>.conf`.

Edit `theme.conf.user` to override the chosen preset, for example:

```ini
[General]
Font="Open Sans"
FontSize="13"
RoundCorners="20"
FormPosition="center"
HideVirtualKeyboard="true"
```

Overrides apply to every preset. Comment out a key to inherit the preset's
value; SDDM ignores empty override values. Inspect the selected preset under
`/usr/share/sddm/themes/sddm-astronaut-theme/Themes/` for the available keys.

For a custom background, add a root-owned, world-readable image to
`system_files/etc/sddm/astronaut/background.png`, then set:

```ini
Background="file:///etc/sddm/astronaut/background.png"
```

This avoids depending on private files in a user's home directory. Animated
presets require codecs supported by the installed multimedia backend; the
default Astronaut preset uses a static PNG.

## Preview and test

After building and booting the new image, preview the theme inside your desktop:

```bash
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/sddm-astronaut-theme
```

Previewing checks QML rendering, not PAM authentication, Weston startup,
SELinux access, or the handoff to your desktop. Test a real reboot and login
on the target NVIDIA machine before relying on this image. Verify that Niri
appears in the session picker and starts; Hyprland is only available if its
packages are installed (its installation block is currently commented out).

The build verifies the greeter packages, Weston/Qt 6 greeter executables, and
editable theme links after cleanup. `bootc container lint` still runs at the
end of the Containerfile. Build with `just build` in a Podman environment.

## Switching and existing deployments

After booting an image containing this integration, choose one command:

```bash
ujust gondor-greeter sddm
ujust gondor-greeter noctalia
```

Then reboot. These commands change enablement for the next boot and do not
stop the active login manager. Existing deployments can retain locally changed
service symlinks; explicitly select SDDM once if greetd still starts.

Existing local `/etc/sddm.conf` edits can also override new image defaults.
Compare that file with the repository version, particularly `Current`,
`ThemeDir`, `CompositorCommand`, and `[Autologin]`. Check the selected manager
with `readlink -f /etc/systemd/system/display-manager.service`.

If the login screen fails, switch to a TTY (Ctrl+Alt+F3), log in, and inspect:

```bash
systemctl status sddm.service
journalctl -b -u sddm.service
```

To return to Noctalia from the TTY:

```bash
sudo systemctl disable sddm.service
sudo systemctl enable --force greetd.service
sudo reboot
```

The existing Noctalia configuration and persistent state are retained.
