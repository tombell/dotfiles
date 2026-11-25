#!/usr/bin/env bash
# Read-only CPU, memory, and thermal snapshot for the fleet.
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
fleet_exec="$script_dir/fleet-exec.sh"

hosts=("$@")
if [[ ${#hosts[@]} -eq 0 ]]; then
  hosts=(pyra brighid rpi)
fi

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

# Both probes take a 3 second sample so %CPU reflects current use, not the
# average since process start.
IFS= read -r -d '' probe_macos <<'EOF' || true
cores=$(sysctl -n hw.ncpu)
perf=$(sysctl -n hw.perflevel0.logicalcpu 2>/dev/null || echo "?")
eff=$(sysctl -n hw.perflevel1.logicalcpu 2>/dev/null || echo "?")
load=$(sysctl -n vm.loadavg | tr -d '{}' | awk '{print $1, $2, $3}')
power=$(pmset -g batt 2>/dev/null | sed -n "s/^Now drawing from '\(.*\)'/\1/p")
echo "Cores:     $cores ($perf performance, $eff efficiency)"
echo "Load:      $load (1, 5, 15 min)"
echo "Power:     ${power:-unknown}"
therm=$(pmset -g therm 2>/dev/null | grep -iE 'limit|warning level' | grep -v 'No ' | sed 's/^[[:space:]]*//' | paste -sd ';' -)
echo "Thermal:   ${therm:-no warnings}"
top -l 2 -s 3 -o cpu -n 10 -stats pid,command,cpu,time,mem 2>/dev/null |
  awk '/^Processes/ {n++} n == 2' |
  awk '/^CPU usage/ {sub(/^CPU usage: /, ""); print "CPU:       " $0}
       /^PhysMem/ {sub(/^PhysMem: /, ""); print "Memory:    " $0}
       /^PID/ {p=1} p'
EOF

IFS= read -r -d '' probe_linux <<'EOF' || true
read -r l1 l5 l15 _ < /proc/loadavg
echo "Cores:     $(nproc)"
echo "Load:      $l1 $l5 $l15 (1, 5, 15 min)"
if [ -r /sys/class/thermal/thermal_zone0/temp ]; then
  echo "Temp:      $(awk '{printf "%.1f C", $1 / 1000}' /sys/class/thermal/thermal_zone0/temp)"
fi
if throttled=$(vcgencmd get_throttled 2>/dev/null); then
  echo "Throttle:  ${throttled#throttled=}"
fi
free -m | awk '/^Mem:/ {printf "Memory:    %s MiB available of %s MiB\n", $7, $2} /^Swap:/ {printf "Swap:      %s of %s MiB used\n", $3, $2}'
top -b -n 2 -d 3 -o %CPU -w 120 2>/dev/null |
  awk '/^top -/ {n++} n == 2' |
  awk '/^%Cpu/ {sub(/^%Cpu\(s\): */, ""); print "CPU:       " $0}
       /PID/ {p=1; c=0} p && c++ <= 10'
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
  probe="if [ \"\$(uname -s)\" = Darwin ]; then
${probe_macos}
else
${probe_linux}
fi"

  {
    printf '=== %s (%s: %s) ===\n' "$host" "$transport" "$target"
    if [[ -s "$err_file" ]]; then
      cat "$err_file"
    fi
    FLEET_RESOLVED_TRANSPORT="$transport" FLEET_RESOLVED_TARGET="$target" \
      "$fleet_exec" "$host" -- "$probe" 2>&1 || printf 'CPU probe exited with error.\n'
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
