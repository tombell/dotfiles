#!/usr/bin/env bash
# Read-only disk usage report for the fleet. Never deletes anything.
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
fleet_exec="$script_dir/fleet-exec.sh"

hosts=("$@")
if [[ ${#hosts[@]} -eq 0 ]]; then
  hosts=(pyra brighid rpi)
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

# Shared helpers for the remote probe (POSIX sh).
IFS= read -r -d '' probe_common <<'EOF' || true
section() { printf '\n## %s\n' "$1"; }
# sz <path> [note]: print the size of a path when it exists.
sz() {
  [ -e "$1" ] || return 0
  s=$(du -sh "$1" 2>/dev/null | awk '{print $1}')
  [ -n "$s" ] || s="?"
  printf '  %-7s %s%s\n' "$s" "$(printf '%s' "$1" | sed "s|^$HOME|~|")" "${2:+  ($2)}"
}
# top <dir> [n]: largest direct children of a directory.
top() {
  [ -d "$1" ] || return 0
  du -xhd1 "$1" 2>/dev/null | sort -rh | sed 1d | head -n "${2:-8}" |
    awk -v h="$HOME" '{s=$1; $1=""; sub(/^ /,""); sub("^" h, "~"); printf "  %-7s %s\n", s, $0}'
}
has_sudo=no
sudo -n true >/dev/null 2>&1 && has_sudo=yes
EOF

IFS= read -r -d '' probe_macos <<'EOF' || true
section "Volumes"
df -h /System/Volumes/Data | awk 'NR==2 {printf "  Data: %s used, %s avail of %s (%s)\n", $3, $4, $2, $5}'
diskutil apfs list 2>/dev/null | sed 's/^[|+ -]*//' |
  awk 'function hr(s) { if (match(s, /\([0-9.]+ [KMGT]?B\)/)) return substr(s, RSTART + 1, RLENGTH - 2); return "?" }
       /^Container disk/ {c=$2} /^Capacity In Use By Volumes/ {u=hr($0)} /^Capacity Not Allocated/ {printf "  %s: %s in use, %s unallocated\n", c, u, hr($0)}
       /^Name:/ {n=$0; sub(/^Name: */,"",n); sub(/ \(Case-.*/,"",n)} /^Capacity Consumed/ {printf "    %-28s %s\n", n, hr($0)}'
df -h | awk 'NR>1 && $NF ~ /^\/Volumes\// && $NF !~ /Simulator|^\/Volumes\/Recovery$/ {printf "  External %s: %s used, %s avail of %s (%s)\n", $NF, $3, $4, $2, $5}'
snaps=$(tmutil listlocalsnapshots / 2>/dev/null | sed 1d | wc -l | tr -d ' ')
echo "  Local Time Machine snapshots: $snaps"

section "Home (top level)"
top "$HOME" 10

section "T3 Code"
top "$HOME/.t3/scratch" 6
state="$HOME/.t3/runtime/service-state.json"
if [ -r "$state" ]; then
  active=$(sed -n 's/.*"activeVersion": *"\([^"]*\)".*/\1/p' "$state" | head -n 1)
  status=$(sed -n 's/.*"status": *"\([^"]*\)".*/\1/p' "$state" | head -n 1)
  echo "  Runtime: active=$active update=${status:-none}"
  for v in "$HOME"/.t3/runtime/versions/*; do
    [ -d "$v" ] || continue
    case "$(basename "$v")" in "$active") sz "$v" "active" ;; *) sz "$v" "older" ;; esac
  done
fi
sz "$HOME/Library/Caches/t3code-updater" "updater cache"
sz "$HOME/.t3/worktrees"

section "Xcode and simulators"
sz "$HOME/Library/Developer/Xcode/DerivedData"
sz "$HOME/Library/Developer/Xcode/Archives"
for d in "$HOME/Library/Developer/Xcode/iOS DeviceSupport"/* "$HOME/Library/Developer/Xcode/watchOS DeviceSupport"/*; do sz "$d"; done
if command -v xcrun >/dev/null 2>&1 && command -v python3 >/dev/null 2>&1; then
  xcrun simctl list -j runtimes devices 2>/dev/null | python3 -c '
import json, sys
d = json.load(sys.stdin)
used = {k: len(v) for k, v in d["devices"].items() if v}
for r in d["runtimes"]:
    n = used.get(r["identifier"], 0)
    print("  runtime %-28s %-14s devices=%d%s" % (r["name"], r["buildversion"], n, "  (unused)" if n == 0 else ""))
' 2>/dev/null || true
  xcrun simctl runtime list 2>/dev/null | sed -n 's/^Total Disk Images: */  runtime images: /p'
  devs="$HOME/Library/Developer/CoreSimulator/Devices"
  if [ -d "$devs" ]; then
    du -sh "$devs"/*/ 2>/dev/null | sort -rh | head -n 3 | while read -r s p; do
      u=$(basename "$p")
      n=$(xcrun simctl list devices 2>/dev/null | grep "$u" | sed 's/^ *//; s/ (.*//')
      printf '  %-7s sim device %s (%s)\n' "$s" "${n:-unknown}" "$u"
    done
  fi
fi

section "Package, tool and browser caches"
sz "$HOME/Library/pnpm" "pnpm store"
sz "$HOME/.bun/install/cache"
sz "$HOME/.npm"
command -v brew >/dev/null 2>&1 && sz "$(brew --cache)" "Homebrew"
sz "$HOME/Library/Caches/ms-playwright"
sz "$HOME/.cache/uv"
sz "$HOME/Library/Caches/pip"
sz "$HOME/.cache/codex-runtimes"
sz "$HOME/Library/Caches/net.imput.helium" "Helium"
sz "$HOME/Library/Caches/Google"
if command -v mise >/dev/null 2>&1; then
  (cd "$HOME" && mise prune --dry-run 2>&1) | sed -n 's/.*mise \([^ ]*\) is prunable.*/  mise prunable: \1/p'
fi
if command -v container >/dev/null 2>&1; then
  if cdf=$(container system df 2>/dev/null); then
    printf '%s\n' "$cdf" | sed 's/^/  container: /'
  else
    echo "  container: service not running"
  fi
fi

section "Other"
for d in "$HOME/Downloads" "$HOME/.Trash"; do
  if ls "$d" >/dev/null 2>&1; then sz "$d"; else echo "  ?       $(printf '%s' "$d" | sed "s|^$HOME|~|")  (not readable: macOS privacy)"; fi
done
[ -e "/macOS Install Data" ] && echo "  present /macOS Install Data  (stale update staging; size needs sudo)"
if command -v transmission-remote >/dev/null 2>&1; then
  tl=$(transmission-remote -l 2>/dev/null) || tl=""
  if [ -n "$tl" ]; then
    n=$(printf '%s\n' "$tl" | sed '1d;$d' | wc -l | tr -d ' ')
    printf '%s\n' "$tl" | awk -v n="$n" '/^Sum:/ {printf "  torrents: %s, total %s %s\n", n, $2, $3}'
  fi
fi

section "System areas (sudo)"
if [ "$has_sudo" = yes ]; then
  top /System/Volumes/Data 10
  top /System/Volumes/Data/System/Library/AssetsV2 6
  top /private/tmp 4
else
  echo "  skipped: sudo needs a password (see runbook section 8)"
fi
EOF

IFS= read -r -d '' probe_linux <<'EOF' || true
section "Filesystems"
df -hT -x tmpfs -x devtmpfs 2>/dev/null | awk 'NR>1 {printf "  %s (%s): %s used, %s avail of %s (%s)\n", $7, $2, $4, $5, $3, $6}'
free -h 2>/dev/null | awk '/^Swap:/ {printf "  Swap: %s used of %s\n", $3, $2}'

section "Root (top level)"
top / 8

section "Caches and logs"
sz /var/cache/apt "apt clean"
sz /var/lib/apt/lists "rebuilt by apt update"
journalctl --disk-usage 2>/dev/null | sed 's/^/  /'
top /var/log 3

section "Kernel and boot"
running=$(uname -r)
kver=${running%%-*}
echo "  running kernel: $running"
for m in /lib/modules/*; do
  [ -d "$m" ] || continue
  case "$(basename "$m")" in "$kver"*) ;; *) sz "$m" "not the running kernel version" ;; esac
done
sz /boot.bak "boot partition backup"

section "Services and home"
sz /var/lib/homebridge/backups "Homebridge backups"
sz /var/lib/homebridge
sz /opt/homebridge
sz /etc/pihole
top "$HOME" 5
[ "$has_sudo" = yes ] || echo "  note: sudo needs a password; root-only paths may be undercounted"
EOF

report_host() {
  local raw_host="$1"
  local out="$2"
  local host
  host="$(printf '%s' "$raw_host" | tr '[:upper:]' '[:lower:]')"
  host="${host%.local}"

  local resolved err_file
  err_file="${out}.err"
  if ! resolved="$("$fleet_exec" --resolve-only "$host" 2>"$err_file")"; then
    {
      printf '=== %s (UNREACHABLE) ===\n' "$host"
      cat "$err_file"
      printf '\n'
    } >"$out"
    return 0
  fi

  local transport target
  transport="${resolved%% *}"
  target="${resolved#* }"

  local probe
  probe="${probe_common}
if [ \"\$(uname -s)\" = Darwin ]; then
${probe_macos}
else
${probe_linux}
fi"

  {
    printf '=== %s (%s: %s) ===' "$host" "$transport" "$target"
    if [[ -s "$err_file" ]]; then
      printf '\n'
      cat "$err_file"
    fi
    FLEET_RESOLVED_TRANSPORT="$transport" FLEET_RESOLVED_TARGET="$target" \
      "$fleet_exec" "$host" -- "$probe" 2>&1 || printf 'Disk probe exited with error.\n'
    printf '\n'
  } >"$out"
}

pids=()
idx=0
for h in "${hosts[@]}"; do
  out="$tmpdir/$(printf '%02d' "$idx").out"
  report_host "$h" "$out" &
  pids+=("$!")
  idx=$((idx + 1))
done

for pid in "${pids[@]}"; do
  wait "$pid" || true
done

for ((i = 0; i < idx; i++)); do
  cat "$tmpdir/$(printf '%02d' "$i").out"
done
