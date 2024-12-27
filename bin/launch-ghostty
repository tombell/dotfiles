#!/usr/bin/env bash

osascript -e 'if application "Ghostty" is running then' \
          -e '  tell application "System Events" to click menu item "New Window" of menu "File" of menu bar 1 of process "Ghostty"' \
          -e 'else' \
          -e '  tell application "Ghostty" to activate' \
          -e 'end if' > /dev/null
