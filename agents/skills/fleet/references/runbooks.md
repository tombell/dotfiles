# Fleet runbooks

Standard procedures for common fleet tasks. All remote commands go through `~/.agents/skills/fleet/scripts/fleet-exec.sh` so local-first detection, Tailscale -> `.local` fallback, and macOS `PATH` setup happen consistently.

## 1. Fleet health check

Run the parallel read-only status sweep:

```sh
~/.agents/skills/fleet/scripts/fleet-status.sh
```

To check a subset of hosts:

```sh
~/.agents/skills/fleet/scripts/fleet-status.sh brighid rpi
```

## 2. Ad-hoc remote commands

```sh
~/.agents/skills/fleet/scripts/fleet-exec.sh brighid -- 'uptime && df -h /'
~/.agents/skills/fleet/scripts/fleet-exec.sh rpi -- 'systemctl is-active pihole-FTL homebridge fr24feed rex'
```

Pass `--verbose` before the host name to print the resolved transport (`local`, `tailscale`, or `local-mdns`) to stderr.

## 3. Dotfiles and `~/.laptop` maintenance

Always inspect repo status first on each target host (`jj status` when `.jj` exists, otherwise `git status`). Never pull over uncommitted edits without confirming.

### Inspect drift

```sh
~/.agents/skills/fleet/scripts/fleet-exec.sh <host> -- '
  for repo in "$HOME/.dotfiles" "$HOME/.laptop"; do
    [ -d "$repo" ] || continue
    echo "=== $repo ==="
    if [ -d "$repo/.jj" ] && command -v jj >/dev/null 2>&1; then
      jj -R "$repo" status
    else
      git -C "$repo" status -sb
    fi
  done
'
```

### Sync dotfiles only

Pull `~/.dotfiles`, then reapply `rcup` with the host's exact flags from `~/.laptop`:

- **`pyra`:**
  ```sh
  rcup -d ~/.dotfiles -t macos -t personal -S agents/skills -S config/rex/custom_ui -x LICENSE -x README.md
  ```
- **`brighid`:**
  ```sh
  rcup -d ~/.dotfiles -t macos -t mini -S agents/skills -S config/rex/custom_ui -x LICENSE -x README.md
  ```
- **`rpi`:**
  ```sh
  rcup -d ~/.dotfiles -S agents/skills -S config/rex/custom_ui -x LICENSE -x README.md -K -x agents -x claude -x codex -x gemini -x t3 -x config/nvim -x ssh/config
  ```

### Full `~/.laptop` setup rerun

Prefer targeted updates (`rcup`, `brew bundle`, `apt`) for routine maintenance. Only run `./setup` when reconciling full machine state (and note `macos` setup touches `defaults.sh`, `xcode.sh`, `1password`, and `mas`, while `debian rpi` needs `sudo`):

- `pyra`: `cd ~/.laptop && ./setup macos pyra`
- `brighid`: `cd ~/.laptop && ./setup macos brighid`
- `rpi`: `cd ~/.laptop && ./setup debian rpi`

## 4. Package and runtime updates

Always preview updates first; apply only when requested.

### macOS (`pyra`, `brighid`)

- **Preview:**
  ```sh
  brew update >/dev/null && brew outdated
  mise outdated 2>/dev/null || true
  ```
- **Apply Homebrew + Brewfile sync:**
  ```sh
  brew upgrade
  HOMEBREW_LAPTOP_MACHINE=<personal|mini> brew bundle check --file ~/.laptop/macos/Brewfile
  ```
  Run `brew bundle --file ~/.laptop/macos/Brewfile` if Brewfile packages are missing.

### Debian (`rpi`)

- **Preview (no sudo needed for listing if cache is fresh; `apt-get update` needs sudo):**
  ```sh
  apt list --upgradable 2>/dev/null
  test -f /var/run/reboot-required && echo "REBOOT REQUIRED" || echo "no reboot pending"
  ```
- **Apply:** Requires `sudo`. Verify `sudo -n true` first; if it prompts, use T3 `request_secret` (`delivery: "file"`) or give the user the fish command to run:
  ```fish
  ssh pi@rpi.local 'sudo apt-get update && sudo apt-get upgrade'
  ```
  Check `/var/run/reboot-required` afterward and report it without rebooting automatically.

## 5. `brighid` service playbooks

### `poppet`

- Check LaunchAgent and process:
  ```sh
  launchctl list | grep -i poppet || true
  pgrep -fl poppet || true
  ```
- Inspect plist for exact log paths and program arguments:
  ```sh
  cat ~/Library/LaunchAgents/run.poppet.worker.*.plist
  ```
- Restart only when asked (using the exact label from the plist):
  ```sh
  launchctl kickstart -k "gui/$(id -u)/<label>"
  ```

### `hem-web` (Apple `container`)

- Inspect containers and daemon status:
  ```sh
  container ls -a
  container system status || true
  brew services info container
  ```
- Logs:
  ```sh
  container logs hem-web | tail -n 100
  ```
- Restart container (only when asked):
  ```sh
  container stop hem-web && container start hem-web
  container ls -a
  ```

### Torrents (`transmission-cli`)

- Service status and logs:
  ```sh
  brew services info transmission-cli
  tail -n 50 /opt/homebrew/var/transmission/transmission-daemon.log
  ```
- List active torrents:
  ```sh
  transmission-remote -l
  ```
- Restart service (only when asked):
  ```sh
  brew services restart transmission-cli
  ```

### `postgresql@18` and `t3code`

- Status:
  ```sh
  brew services info postgresql@18
  launchctl list | grep -i t3code || true
  ```

### Xcode and Simulators

- Inspect installed Xcode and available simulators:
  ```sh
  xcodebuild -version
  xcrun simctl list devices available
  ```
- For heavier Xcode builds or repo work on `brighid`, consider delegating via T3's linked `Brighid` environment (`t3_environment_links` / `delegate_task`) so the agent works directly on `brighid`.

## 6. `rpi` service playbooks

- Status of all key units:
  ```sh
  systemctl is-active pihole-FTL homebridge fr24feed rex tailscaled
  systemctl --failed --no-pager
  ```
- Inspect logs (check if user `pi` is in `systemd-journal` before assuming `sudo` is needed):
  ```sh
  journalctl -u <service> -n 80 --no-pager
  ```
- Restart a unit (requires `sudo`; confirm before touching `pihole-FTL` or `tailscaled`):
  ```sh
  sudo systemctl restart <service> && systemctl is-active <service>
  ```

## 7. File transfers and Tailscale host keys

### Transferring files

Prefer `rsync` with `--dry-run` before mutating remote directories:

```sh
rsync -avz --dry-run <src> <user>@<resolved-host>:<dest>
```

### One-time Tailscale `known_hosts` bootstrap

If `fleet-exec.sh` reports that Tailscale SSH fell back to `.local` because the tailnet host key is not yet trusted, give the user this `fish` command to verify and accept the tailnet host keys once (so off-LAN Tailscale SSH works seamlessly):

```fish
set suffix (tailscale status --json | python3 -c 'import json,sys; print(json.load(sys.stdin).get("MagicDNSSuffix",""))')
ssh tombell@brighid.$suffix true
ssh pi@rpi.$suffix true
```
