set -g fish_color_command green
set -g fish_color_error red
set -g fish_color_autosuggestion brblack
set -g fish_greeting

if test -f "$HOME/.local.fish"
    source "$HOME/.local.fish"
end
