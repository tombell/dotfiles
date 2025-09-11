#!/usr/bin/env bash
set -euo pipefail

"$(dirname "$0")/ssh.sh"

source "$(dirname "$0")/common.sh"

rcup_install linux
