#!/usr/bin/env bash
set -e

if [ ! pgrep -f "iTerm" > /dev/null ]; then
  open -a "/Applications/iTerm.app"
else
  if ! osascript -e 'tell application "iTerm2" to create window with default profile' > /dev/null; then
    for i in $(pgrep -f "iTerm"); do kill -15 "$i"; done
    open  -a "/Applications/iTerm.app"
  fi
fi
