#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing homebrew formulae and casks..."
brew bundle --file "$(dirname "$0")/Brewfile"
