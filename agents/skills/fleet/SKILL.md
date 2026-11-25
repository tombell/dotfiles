---
name: fleet
description: >-
  Manage and inspect the personal device fleet (pyra MacBook Air, brighid Mac mini,
  and rpi Raspberry Pi). Use when checking fleet health or uptime, running remote
  commands, syncing ~/.dotfiles or ~/.laptop setup scripts, updating Homebrew/apt/mise
  packages, troubleshooting or controlling services on brighid (poppet, hem-web Apple
  container, transmission-cli, postgresql@18, t3code, Xcode/simulators) or rpi
  (pihole-FTL, homebridge, fr24feed, rex), transferring files between hosts, or deciding
  between SSH and T3 Code linked environments.
---

# Fleet management

Inspect, maintain, and run tasks across `pyra`, `brighid`, and `rpi`. Treat the references as hints and verify live state on the target host before acting.

## Fleet at a glance

| Host | Hardware / OS | SSH user | Availability | Primary role |
| --- | --- | --- | --- | --- |
| `pyra` | MacBook Air (macOS ARM64) | `tombell` | Sleep-prone laptop | Daily driver |
| `brighid` | Mac mini (macOS ARM64) | `tombell` | Always-on | `poppet`, `hem-web` container, torrents (`transmission-cli`), Xcode/simulators, T3 linked host |
| `rpi` | Raspberry Pi 3B (Debian `trixie` ARM64) | `pi` | Always-on | `pihole-FTL`, `homebridge`, `fr24feed`, `rex` |

Read [devices](references/devices.md) for service names, paths, LaunchAgents, `systemd` units, and `~/.laptop` / `rcm` details. Read [runbooks](references/runbooks.md) when executing maintenance, update, or service procedures.

## Transport and execution

1. **Local first:** Check `hostname -s` (case-insensitive) before using SSH. If already running on the target host, execute commands locally.
2. **Tailnet first, `.local` fallback:** Resolve the Tailscale MagicDNS FQDN dynamically via `tailscale status --json` (`<host>.<MagicDNSSuffix>`), falling back to `<host>.local` on LAN. Never hardcode private tailnet suffixes or IP addresses into repo files.
3. **Use the helper scripts:**
   - Run single-host commands with [fleet-exec.sh](scripts/fleet-exec.sh):
     `~/.agents/skills/fleet/scripts/fleet-exec.sh <host> -- '<posix sh command>'`
   - Run a parallel read-only health check across all (or selected) hosts with [fleet-status.sh](scripts/fleet-status.sh):
     `~/.agents/skills/fleet/scripts/fleet-status.sh [host ...]`
4. **Non-interactive SSH:** Always pass `-o BatchMode=yes -o ConnectTimeout=5`. All three hosts authenticate with `~/.ssh/Personal` (managed in 1Password via `~/.laptop/common/ssh.sh` and loaded in `ssh-agent`). Never disable host key verification (`StrictHostKeyChecking=no`). If a tailnet host key is not yet in `~/.ssh/known_hosts`, fall back to `.local` and report that the tailnet host key needs a one-time trust.
5. **Shell and PATH:** All hosts use `fish` interactively. Wrap remote commands in POSIX `sh -c '...'` for portability. Non-interactive SSH on macOS omits Homebrew and `mise` from `PATH`; `fleet-exec.sh` prepends `/opt/homebrew/bin`, `/usr/local/bin`, `~/.local/bin`, and `~/.local/share/mise/shims` automatically.
6. **SSH vs T3 Code:**
   - Use SSH (`fleet-exec.sh`) for inspection, logs, service restarts, package/dotfiles updates, and `rsync`.
   - When running in T3 Code and the task is heavier agent work on `brighid` (builds, repo edits, long-running coding), check `t3_environment_links` and delegate to the linked `Brighid` environment instead of driving long interactive work over SSH.
   - For iOS Simulator UI interaction on a T3-attached device host, use T3's `device_*` tools rather than raw `xcrun simctl` UI commands.

## Safety guardrails

- **Read-only by default:** Inspect state first. Do not install, upgrade, restart, or edit configs unless the user asked for that change.
- **Canary or dry-run first:** Preview fleet-wide changes (`brew outdated`, `apt list --upgradable`, `rsync --dry-run`) or apply to one host and verify before rolling out to the rest.
- **No hanging `sudo`:** Check `sudo -n true` before privileged commands (`rpi` requires a sudo password). Never block on a TTY prompt; if elevation is needed, use T3 `request_secret` (`delivery: "file"`) or ask the user to run the command.
- **Confirm before disruptive actions:** Ask before rebooting/shutting down headless hosts (`brighid`, `rpi`), editing SSH/Tailscale/firewall/network settings, stopping or changing `pihole-FTL` (home DNS), deleting data or torrents, or recreating containers.
- **Respect `~/.laptop` and `~/.dotfiles`:** Prefer the repo's existing `./setup` profiles and `rcm` flags over ad-hoc edits. Check `jj status` (or `git status`) before pulling so local edits are never clobbered.

## Report

Summarize multi-host results per device:

- Host and transport used (`local`, `tailscale`, `local-mdns`, or `unreachable` with reason)
- Key findings or changes made
- Verification run and observed state (e.g., active service/container status, clean working copy)
- Any remaining failures, reboot requirements, or manual steps needed
