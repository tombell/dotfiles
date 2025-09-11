#!/usr/bin/env bash
set -euo pipefail

"$(dirname "$0")/ssh.sh"

source "$(dirname "$0")/common.sh"

"$(dirname "$0")/brew.sh"

rcup_install macos -- -S karabiner

"$(dirname "$0")/defaults.sh"
