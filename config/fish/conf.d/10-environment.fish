set -gx XDG_CONFIG_HOME "$HOME/.config"

set -gx VISUAL nvim
set -gx EDITOR $VISUAL

set -gx CLICOLOR 1
set -gx GOPATH "$HOME/.local/share/go"

set -gx EZA_CONFIG_DIR "$XDG_CONFIG_HOME/eza"

fish_add_path --move --path \
    "$HOME/.local/share/neovim/bin" \
    "$GOPATH/bin" \
    "$HOME/.local/bin"
