# Fleet devices

Operational reference for each machine. Always verify live state on the host before mutating services or configs.

## `pyra` — MacBook Air

- **OS / Arch:** macOS, Apple Silicon (`arm64`), ComputerName `Pyra`
- **SSH user:** `tombell` (key: `~/.ssh/Personal`)
- **Interactive shell:** `fish`
- **Availability:** Laptop; may be asleep or off-LAN
- **Dotfiles / setup:**
  - `~/.laptop`: `./setup macos pyra` (`HOMEBREW_LAPTOP_MACHINE=personal`)
  - `rcm` tags: `-t macos -t personal -t ai`
- **Key tooling:** Homebrew (`swm`, `skbd@2`, `container`, `mise`, `rcm`, `jj`, `mas`, `1password`, `t3-code@nightly`, `tailscale-app`), Rex

## `brighid` — Mac mini

- **OS / Arch:** macOS, Apple Silicon (`arm64`), ComputerName `Brighid`
- **SSH user:** `tombell` (key: `~/.ssh/Personal`)
- **Interactive shell:** `fish`
- **Availability:** Always-on headless server / build host
- **T3 Code:** Linked T3 environment (`Brighid`, reachable over T3 Code) + LaunchAgent `~/Library/LaunchAgents/com.t3tools.t3code.service.plist`
- **Dotfiles / setup:**
  - `~/.laptop`: `./setup macos brighid` (`HOMEBREW_LAPTOP_MACHINE=mini`)
  - `rcm` tags: `-t macos -t mini -t ai`
- **Workloads and services:**
  - **`poppet`:** Background worker managed by LaunchAgent `~/Library/LaunchAgents/run.poppet.worker.*.plist`, running via `mise` Bun from `~/Code/poppet-run/poppet`.
  - **`hem-web` (Apple `container`):** Runs as a Linux `arm64` container via the Homebrew `container` CLI (`container ls -a`). Paired with the `buildkit` builder container. Managed by LaunchAgent `~/Library/LaunchAgents/sh.brew.container.plist` (`brew services`).
  - **Torrents (`transmission-cli`):** Managed by `brew services` (`~/Library/LaunchAgents/sh.brew.transmission-cli.plist`). Config and logs live in `/opt/homebrew/var/transmission/` (`transmission-daemon.log`). Control via `transmission-remote`.
  - **Xcode & Simulators:** Full Xcode installation (`xcodebuild`) with iOS and watchOS simulators (`xcrun simctl`) for offloading builds and tests.
  - **Rex:** Tailscale companion node (`brighid-rex`).

## `rpi` — Raspberry Pi

- **Hardware / OS / Arch:** Raspberry Pi 3 Model B Rev 1.2, Debian GNU/Linux 13 (`trixie`), `aarch64`
- **SSH user:** `pi` (differs from macOS user `tombell`; key: `~/.ssh/Personal`)
- **SSH note:** `~/.ssh/config` sets `AddressFamily inet` for `rpi.local` to avoid IPv6 mDNS issues.
- **Interactive shell:** `fish`
- **Sudo:** Requires password (`sudo -n true` fails). Do not run unattended `sudo` commands without credentials.
- **Availability:** Always-on headless server
- **Dotfiles / setup:**
  - `~/.laptop`: `./setup debian rpi`
  - Packages list: `~/.laptop/linux/debian/packages/apt.txt`
  - `rcm` skips hooks and desktop/agent configs:
    `rcup -d ~/.dotfiles -S agents/skills -S config/rex/custom_ui -x LICENSE -x README.md -K -x config/nvim -x ssh/config`
- **Systemd services:**
  - **`pihole-FTL.service`:** Home DNS / Pi-hole. Treat as critical network infrastructure; confirm before restarting or editing config.
  - **`homebridge.service`:** HomeKit bridge.
  - **`fr24feed.service`:** Flightradar24 ADS-B feeder (plus optional `fr24gui.service` / `fr24uat-feed.service`).
  - **`rex.service`:** Rex service (Tailscale companion node `rpi-rex`).
  - **Base services:** `tailscaled.service`, `ssh.service`, `watchdog.service`.
