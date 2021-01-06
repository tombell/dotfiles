#!/usr/bin/env bash
set -e

# Comment out lines 6, 7, 9, and 18 if not using aggregate device

mic_device="Bose QuietComfort 35 Series II"
aggregate_device="Mic"

SwitchAudioSource -t input -s "$mic_device"

osascript \
  -e 'if input volume of (get volume settings) = 0 then' \
  -e '  set volume input volume 50' \
  -e 'else' \
  -e '  set volume input volume 0' \
  -e 'end if'

SwitchAudioSource -t input -s "$aggregate_device"