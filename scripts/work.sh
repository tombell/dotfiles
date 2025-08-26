#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/common.sh"

"$(dirname "$0")/brew.sh"

rcup_install macos work -- -S karabiner

"$(dirname "$0")/defaults.sh"
