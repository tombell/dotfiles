#!/usr/bin/env bash
set -e

cd ~/Code/backstage   && tmux new-session -d -s backstage
cd ~/Code/doorbell    && tmux new-session -d -s doorbell
cd ~/Code/foundations && tmux new-session -d -s foundations
cd ~/Code/frontdoor   && tmux new-session -d -s frontdoor
cd ~/Code/key-chain   && tmux new-session -d -s key-chain
cd ~/Code/letterbox   && tmux new-session -d -s letterbox
cd ~/Code/living      && tmux new-session -d -s living
cd ~/Code/marketing   && tmux new-session -d -s marketing
cd ~/Code/piggybank   && tmux new-session -d -s piggybank
cd ~/Code/switchboard && tmux new-session -d -s switchboard
