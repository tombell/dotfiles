#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF' >&2
Usage:
  fleet-exec.sh [--verbose] <host> -- <posix sh command>
  fleet-exec.sh [--verbose] --resolve-only <host>

Hosts: pyra, brighid, rpi (optional .local suffix accepted)
EOF
}

verbose=0
resolve_only=0

while [[ $# -gt 0 ]]; do
  case "$1" in
  -v | --verbose)
    verbose=1
    shift
    ;;
  --resolve-only)
    resolve_only=1
    shift
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  --)
    shift
    break
    ;;
  -*)
    echo "Unknown option: $1" >&2
    usage
    exit 2
    ;;
  *)
    break
    ;;
  esac
done

if [[ $# -lt 1 ]]; then
  usage
  exit 2
fi

raw_host="$1"
shift

if [[ $# -gt 0 && "$1" == "--" ]]; then
  shift
fi

host="$(printf '%s' "$raw_host" | tr '[:upper:]' '[:lower:]')"
host="${host%.local}"

case "$host" in
pyra | brighid)
  ssh_user="tombell"
  target_os="macos"
  mdns_host="${host}.local"
  ;;
rpi)
  ssh_user="pi"
  target_os="linux"
  mdns_host="rpi.local"
  ;;
*)
  echo "Unknown fleet host: $raw_host (expected: pyra, brighid, rpi)" >&2
  exit 2
  ;;
esac

if [[ $resolve_only -eq 0 && $# -lt 1 ]]; then
  echo "Missing command to execute on $host" >&2
  usage
  exit 2
fi

cmd=""
if [[ $# -gt 0 ]]; then
  cmd="$*"
fi

find_tailscale() {
  if command -v tailscale >/dev/null 2>&1; then
    command -v tailscale
  elif [[ -x /Applications/Tailscale.app/Contents/MacOS/Tailscale ]]; then
    printf '%s\n' /Applications/Tailscale.app/Contents/MacOS/Tailscale
  else
    return 1
  fi
}

get_tailnet_suffix() {
  local ts_bin
  ts_bin="$(find_tailscale)" || return 1
  local json
  json="$("$ts_bin" status --json 2>/dev/null)" || return 1
  if command -v python3 >/dev/null 2>&1; then
    printf '%s' "$json" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("MagicDNSSuffix",""))' 2>/dev/null
  else
    printf '%s\n' "$json" | sed -n 's/.*"MagicDNSSuffix"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n 1
  fi
}

ssh_probe() {
  local target="$1"
  shift
  ssh -n -o BatchMode=yes -o ConnectTimeout=4 -o ServerAliveInterval=10 -o ServerAliveCountMax=2 "$@" "$target" true
}

resolve_target() {
  local local_host
  local_host="$(hostname -s | tr '[:upper:]' '[:lower:]')"
  if [[ "$local_host" == "$host" ]]; then
    RESOLVED_TRANSPORT="local"
    RESOLVED_TARGET="$host"
    RESOLVED_EXTRA_ARGS=()
    return 0
  fi

  local ts_suffix=""
  local ts_err=""
  if ts_suffix="$(get_tailnet_suffix)" && [[ -n "$ts_suffix" ]]; then
    local ts_target="${ssh_user}@${host}.${ts_suffix}"
    if ts_err="$(ssh_probe "$ts_target" 2>&1)"; then
      RESOLVED_TRANSPORT="tailscale"
      RESOLVED_TARGET="$ts_target"
      RESOLVED_EXTRA_ARGS=()
      return 0
    fi
  fi

  local mdns_target="${ssh_user}@${mdns_host}"
  local mdns_err=""
  local mdns_ok=0
  if [[ "$host" == "rpi" ]]; then
    if mdns_err="$(ssh_probe "$mdns_target" -4 2>&1)"; then
      mdns_ok=1
      RESOLVED_EXTRA_ARGS=(-4)
    fi
  else
    if mdns_err="$(ssh_probe "$mdns_target" 2>&1)"; then
      mdns_ok=1
      RESOLVED_EXTRA_ARGS=()
    fi
  fi

  if [[ $mdns_ok -eq 1 ]]; then
    if [[ -n "$ts_err" && "$ts_err" == *"Host key verification failed"* ]]; then
      echo "[fleet] $host: tailscale host key not in known_hosts; fell back to $mdns_host" >&2
    fi
    RESOLVED_TRANSPORT="local-mdns"
    RESOLVED_TARGET="$mdns_target"
    return 0
  fi

  echo "[fleet] $host: unreachable" >&2
  if [[ -n "$ts_err" ]]; then
    echo "  tailscale: ${ts_err//$'\n'/ | }" >&2
  fi
  if [[ -n "$mdns_err" ]]; then
    echo "  mdns:      ${mdns_err//$'\n'/ | }" >&2
  fi
  return 1
}

RESOLVED_TRANSPORT="${FLEET_RESOLVED_TRANSPORT:-}"
RESOLVED_TARGET="${FLEET_RESOLVED_TARGET:-}"
RESOLVED_EXTRA_ARGS=()

if [[ -n "$RESOLVED_TRANSPORT" && -n "$RESOLVED_TARGET" ]]; then
  if [[ "$RESOLVED_TRANSPORT" == "local-mdns" && "$host" == "rpi" ]]; then
    RESOLVED_EXTRA_ARGS=(-4)
  fi
else
  resolve_target
fi

if [[ $verbose -eq 1 ]]; then
  echo "[fleet] $host: $RESOLVED_TRANSPORT ($RESOLVED_TARGET)" >&2
fi

if [[ $resolve_only -eq 1 ]]; then
  printf '%s %s\n' "$RESOLVED_TRANSPORT" "$RESOLVED_TARGET"
  exit 0
fi

payload="$cmd"
if [[ "$target_os" == "macos" ]]; then
  # Expand $HOME and $PATH on the remote macOS host, not locally.
  # shellcheck disable=SC2016
  payload='export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"
'"$cmd"
fi

if [[ "$RESOLVED_TRANSPORT" == "local" ]]; then
  exec /bin/sh -c "$payload"
fi

b64="$(printf '%s' "$payload" | base64 | tr -d '\r\n')"
remote_runner="/bin/sh -c 's=\$(printf %s ${b64} | (base64 -d 2>/dev/null || base64 -D)); /bin/sh -c \"\$s\"'"

if [[ ${#RESOLVED_EXTRA_ARGS[@]} -gt 0 ]]; then
  exec ssh -o BatchMode=yes -o ConnectTimeout=5 -o ServerAliveInterval=15 -o ServerAliveCountMax=3 "${RESOLVED_EXTRA_ARGS[@]}" "$RESOLVED_TARGET" "$remote_runner"
else
  exec ssh -o BatchMode=yes -o ConnectTimeout=5 -o ServerAliveInterval=15 -o ServerAliveCountMax=3 "$RESOLVED_TARGET" "$remote_runner"
fi
