#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/common.sh"

"$(dirname "$0")/ssh.sh"
"$(dirname "$0")/brew.sh"
rcup_install macos -- -S karabiner
# "$(dirname "$0")/defaults.sh"
"$(dirname "$0")/mise.sh"
