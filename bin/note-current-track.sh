#!/usr/bin/env bash
set -e

function main {
  /usr/bin/osascript \
    -e 'tell application "Music"' \
    -e '  set track_artist to artist of current track' \
    -e '  set track_name to name of current track' \
    -e '  log track_artist & " - " & track_name' \
    -e 'end tell' 2>> "$HOME/Desktop/tracks.txt"
}

main
