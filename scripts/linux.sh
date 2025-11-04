#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/common.sh"

rcup_install linux
"$(dirname "$0")/mise.sh"
