#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
fleet_exec="$script_dir/fleet-exec.sh"

hosts=("$@")
if [[ ${#hosts[@]} -eq 0 ]]; then
  hosts=(pyra brighid rpi)
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

check_host() {
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

  local probe_cmd host_probe=""
  IFS= read -r -d '' probe_cmd <<'EOF' || true
os_name=$(uname -s)
arch=$(uname -m)
if [ "$os_name" = "Darwin" ]; then
  os_ver="macOS $(sw_vers -productVersion 2>/dev/null || true)"
  disk_path="/System/Volumes/Data"
  [ -d "$disk_path" ] || disk_path="/"
elif [ -r /etc/os-release ]; then
  os_ver=$(sed -n 's/^PRETTY_NAME="\([^"]*\)"/\1/p' /etc/os-release | head -n 1)
  disk_path="/"
else
  os_ver="$os_name $(uname -r)"
  disk_path="/"
fi
up=$(uptime | sed 's/^[[:space:]]*//')
disk=$(df -h "$disk_path" | awk 'NR==2 {printf "%s used, %s avail of %s (%s)", $3, $4, $2, $5}')
echo "OS:        $os_ver ($arch)"
echo "Uptime:    $up"
echo "Disk:      $disk"

for repo in "$HOME/.dotfiles" "$HOME/.laptop"; do
  name=$(basename "$repo")
  if [ ! -d "$repo" ]; then
    echo "Repo $name: missing"
  elif [ -d "$repo/.jj" ] && command -v jj >/dev/null 2>&1; then
    dirty=$(jj -R "$repo" status 2>/dev/null | grep -cE '^[MADRC?] ' || true)
    if [ "$dirty" -eq 0 ]; then
      echo "Repo $name: clean (jj)"
    else
      echo "Repo $name: $dirty modified (jj)"
    fi
  elif [ -d "$repo/.git" ] && command -v git >/dev/null 2>&1; then
    dirty=$(git -C "$repo" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    if [ "$dirty" -eq 0 ]; then
      echo "Repo $name: clean (git)"
    else
      echo "Repo $name: $dirty modified (git)"
    fi
  else
    echo "Repo $name: present"
  fi
done
EOF

  case "$host" in
  pyra)
    IFS= read -r -d '' host_probe <<'EOF' || true
swm_state=$(pgrep -x swm >/dev/null 2>&1 && echo running || echo stopped)
skbd_state=$(pgrep -x skbd >/dev/null 2>&1 && echo running || echo stopped)
echo "Services:  swm=$swm_state skbd=$skbd_state"
EOF
    ;;
  brighid)
    IFS= read -r -d '' host_probe <<'EOF' || true
poppet_state=$(pgrep -f 'poppet.*worker' >/dev/null 2>&1 && echo running || echo stopped)
hem_state=$(container ls -a 2>/dev/null | awk '$1=="hem-web" {print $5; found=1} END {if (!found) print "missing"}')
tx_state=$(brew services list 2>/dev/null | awk '$1=="transmission-cli" {print $2; found=1} END {if (!found) print "unknown"}')
t3_state=$(launchctl list 2>/dev/null | awk '$3=="com.t3tools.t3code.service" {print ($1=="-" ? "loaded" : "running"); found=1} END {if (!found) print "unloaded"}')
echo "Services:  poppet=$poppet_state hem-web=$hem_state transmission=$tx_state t3code=$t3_state"
EOF
    ;;
  rpi)
    IFS= read -r -d '' host_probe <<'EOF' || true
svc_line=""
for svc in pihole-FTL homebridge fr24feed rex tailscaled; do
  st=$(systemctl is-active "$svc" 2>/dev/null || true)
  [ -n "$st" ] || st="unknown"
  svc_line="$svc_line $svc=$st"
done
echo "Services: ${svc_line}"
failed=$(systemctl --failed --no-legend --no-pager 2>/dev/null | wc -l | tr -d ' ')
reboot_req=$([ -f /var/run/reboot-required ] && echo yes || echo no)
echo "Systemd:   failed=$failed reboot-required=$reboot_req"
EOF
    ;;
  esac

  probe_cmd="${probe_cmd}${host_probe}"

  {
    printf '=== %s (%s: %s) ===\n' "$host" "$transport" "$target"
    if [[ -s "$err_file" ]]; then
      cat "$err_file"
    fi
    FLEET_RESOLVED_TRANSPORT="$transport" FLEET_RESOLVED_TARGET="$target" \
      "$fleet_exec" "$host" -- "$probe_cmd" 2>&1 || printf 'Status probe exited with error.\n'
    printf '\n'
  } >"$out"
}

pids=()
idx=0
for h in "${hosts[@]}"; do
  out="$tmpdir/$(printf '%02d' "$idx").out"
  check_host "$h" "$out" &
  pids+=("$!")
  idx=$((idx + 1))
done

for pid in "${pids[@]}"; do
  wait "$pid" || true
done

for ((i = 0; i < idx; i++)); do
  cat "$tmpdir/$(printf '%02d' "$i").out"
done
