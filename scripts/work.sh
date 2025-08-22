#!/usr/bin/env bash
set -euo pipefail

"$(dirname "$0")/brew.sh"

rcup_install macos work -- -S karabiner

"$(dirname "$0")/defaults.sh"

