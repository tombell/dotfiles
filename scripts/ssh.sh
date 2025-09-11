#!/usr/bin/env bash
set -euo pipefail

mkdir -p ~/.ssh

[ -e "~/.ssh/Personal.pub" ] || op read "op://Personal/Personal/public key" >~/.ssh/Personal.pub
[ -e "~/.ssh/Personal" ] || op read "op://Personal/Personal/private key" >~/.ssh/Personal

chmod 600 ~/.ssh/Personal
chmod 600 ~/.ssh/Personal.pub
