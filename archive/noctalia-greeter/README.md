# Archived Noctalia Greeter

This folder preserves the greetd configuration, Noctalia administrator settings,
tmpfiles rule, build steps, and switching recipe. It is excluded from the image's
active build. The Noctalia desktop shell remains installed separately.

To restore Noctalia Greeter, run from the repository root:

```bash
python3 archive/noctalia-greeter/restore.py
just build
```

The restoration command copies the archived configuration into `system_files`,
adds package installation and service selection to the build, and restores
`ujust gondor-greeter`. Repeated runs do not duplicate the build steps. Review
the resulting diff, deploy the rebuilt image as usual, and boot it. For an
existing installation with local service changes, explicitly select Noctalia:

```bash
ujust gondor-greeter noctalia
sudo reboot
```

The restored image retains SDDM; `ujust gondor-greeter sddm` selects it again.
Switching changes the next boot without stopping the current session.

Customize `system_files/etc/noctalia-greeter/greeter.toml` after restoration.
Tmpfiles links `/var/lib/noctalia-greeter/greeter.toml` to the installed `/etc`
file. Existing `/var/lib/noctalia-greeter` appearance sync and UI state survive
image updates; the archive does not include or delete those machine-local files.
An existing regular `greeter.toml` in `/var/lib` is preserved by the tmpfiles
rule; back it up and move it aside before running
`sudo systemd-tmpfiles --create /etc/tmpfiles.d/noctalia-greeter.conf` to use
the `/etc` link. Administrator settings override synced values when specified.
