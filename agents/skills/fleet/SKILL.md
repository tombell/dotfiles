---
name: fleet
description: Manage Tom's fleet of Macs and Raspberry Pi over local networking or Tailscale. Use when checking hosts or updating Homebrew packages on Pyra, Haze, or Brighid, or apt packages on rpi. Also use when the user refers to these computers collectively as the fleet.
---

# Fleet Management

Use [references/inventory.md](references/inventory.md) as the source of truth for host roles, operating systems, addresses, and service context.

## Scope

Currently support:

- Reachability and identity checks
- Inspection of outdated packages
- Homebrew updates on macOS
- apt updates on Raspbian

Do not manage Hermes, container platforms, Homebridge, fr24, UniFi, VLANs, or arbitrary services under this skill. Their presence is inventory context only. Suggest a dedicated skill when the request concerns those systems.

## Resolve and Connect

1. Use the lowercase local hostname first, such as `brighid`.
2. If local resolution or connection fails, use `<host>.solarflare-skink.ts.net`.
3. Use the user's existing SSH configuration and credentials. Never request, print, store, or modify secrets.
4. Do not disable SSH host-key checking or accept a changed host key automatically.
5. Before changing packages, verify identity and OS remotely:

```sh
hostname
uname -srm
[ -f /etc/os-release ] && cat /etc/os-release
```

Stop if the returned identity or operating system conflicts with the inventory.

## Safety Rules

Inspection may run without confirmation. Obtain explicit confirmation immediately before:

- Installing or upgrading packages
- Running `sudo`
- Rebooting or shutting down
- Deleting files or data
- Restarting services
- Performing any fleet-wide mutation

Show the target host, proposed command, and packages affected before asking. A broad request such as "update Brighid" expresses intent but still present the discovered upgrade plan and ask for final confirmation before applying it.

Never update every host concurrently. For fleet-wide work, inspect all requested hosts first, present a per-host plan, confirm once, then update sequentially. Stop on the first failure and report which hosts remain untouched.

Do not add, remove, pin, unpin, autoremove, or clean packages unless specifically requested and separately confirmed.

## macOS / Homebrew

### Inspect

Run remotely:

```sh
HOMEBREW_NO_AUTO_UPDATE=1 brew outdated --verbose
```

If `brew` is not found in a non-interactive SSH shell, locate it without modifying shell configuration:

```sh
command -v brew || [ -x /opt/homebrew/bin/brew ] && echo /opt/homebrew/bin/brew || [ -x /usr/local/bin/brew ] && echo /usr/local/bin/brew
```

Use the discovered absolute path for subsequent commands. Do not assume Intel versus Apple Silicon from the machine's age; verify with `uname -m`.

### Apply after confirmation

```sh
brew update && brew upgrade
```

Do not run `brew cleanup` automatically. Report upgraded packages, failures, and any caveats emitted by Homebrew.

## Raspbian / apt

### Inspect

First inspect OS identity. To obtain a current package plan, explain that refreshing apt metadata uses `sudo`, then get confirmation before running:

```sh
sudo apt-get update
apt list --upgradable 2>/dev/null
```

### Apply after confirmation

Use a normal upgrade rather than a distribution upgrade:

```sh
sudo apt-get upgrade
```

Keep apt interactive unless the user explicitly requests unattended operation. Do not run `dist-upgrade`, `full-upgrade`, `autoremove`, or reboot automatically.

## Reporting

For each host, report:

- Address used: local or Tailnet
- Reachability and verified identity
- Package manager
- Available or completed upgrades
- Errors, warnings, and whether a reboot appears necessary
- Any hosts not attempted
