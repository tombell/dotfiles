#!/usr/bin/env bash
set -e

osascript \
  -e 'if input volume of (get volume settings) = 0 then' \
  -e '  set volume input volume 50' \
  -e 'else' \
  -e '  set volume input volume 0' \
  -e 'end if'
