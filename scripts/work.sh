#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/common.sh"

"$(dirname "$0")/brew.sh"
rcup_install macos work -- -S karabiner
"$(dirname "$0")/defaults.sh"
"$(dirname "$0")/mise.sh"
# TODO: work out best way to modularize SSH setup
# "$(dirname "$0")/ssh.sh"
