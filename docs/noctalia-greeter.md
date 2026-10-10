# Noctalia Greeter configuration and use

Noctalia Greeter is the default login manager, launched by greetd. The build uses
`dnf5 install -y --from-repo=terra noctalia-greeter` to select the Terra package
from the repository already shipped by Bazzite. No additional repository or
Lionheart COPR is enabled. Dependencies are resolved from the enabled base
repositories; greetd is installed separately.

See the upstream [installation guide](https://docs.noctalia.dev/greeter/installation/)
and DNF5's [`--from-repo` option](https://dnf5.readthedocs.io/en/latest/commands/install.8.html).

## Configuration

| Repository file | Purpose |
| --- | --- |
| `system_files/etc/greetd/config.toml` | Session wrapper, greeter account, and virtual terminal |
| `system_files/etc/noctalia-greeter/greeter.toml` | Default session/user, appearance, keyboard, cursor, and outputs |
| `system_files/etc/tmpfiles.d/noctalia-greeter.conf` | State directory ownership and link to administrator settings |

Edit these files and rebuild for image defaults, or edit their installed `/etc`
paths with administrator privileges. Local `/etc` edits survive bootc updates
and can override new image defaults. The restored defaults select Niri and the
`pedro` account, with the US AltGr international keyboard layout.

greetd launches `/usr/bin/noctalia-greeter-session` as `greetd`. The image keeps
the account available at boot through a packaged sysusers rule, or a fallback
rule if the package does not provide one.

Tmpfiles links `/var/lib/noctalia-greeter/greeter.toml` to
`/etc/noctalia-greeter/greeter.toml`. Existing appearance sync and UI state in
`/var/lib/noctalia-greeter` survive image updates. An existing regular
`greeter.toml` there is preserved: back it up and move it aside before running
`sudo systemd-tmpfiles --create /etc/tmpfiles.d/noctalia-greeter.conf` to use the
image's `/etc` configuration. Administrator settings override synced values
when specified. See the upstream [configuration reference](https://docs.noctalia.dev/greeter/configuration/).

## Deployment and switching

Rebuild and deploy the image as usual. New installations select Noctalia
Greeter by default. If an existing installation has local service overrides
from the SDDM setup, select Noctalia after booting the updated image:

```bash
sudo systemctl unmask greetd.service
sudo systemctl enable --force greetd.service
sudo reboot
```

These commands unmask greetd and point `display-manager.service` at greetd for
the next boot without stopping the current session. SDDM and Astronaut are
[archived](../archive/sddm/README.md) and excluded from the active build.
Restoring the archive reinstalls SDDM and its switching recipe.

To inspect Noctalia login problems:

```bash
systemctl status greetd.service
journalctl -b -u greetd.service
```
