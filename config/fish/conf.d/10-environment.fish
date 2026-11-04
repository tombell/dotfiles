set -gx XDG_CONFIG_HOME "$HOME/.config"

set -gx VISUAL nvim
set -gx EDITOR $VISUAL

set -gx CLICOLOR 1
set -gx GOPATH "$HOME/.local/share/go"

set -gx EZA_CONFIG_DIR "$XDG_CONFIG_HOME/eza"

fish_add_path --move --path \
    "$HOME/.local/share/neovim/bin" \
    "$GOPATH/bin" \
    "$HOME/.local/bin" \
    "$HOME/.bun/bin"

# Tokyo Night (night) colours, from folke/tokyonight.nvim extras. Background
# and gutter use the terminal default so fzf matches Ghostty's theme.
set -gx FZF_DEFAULT_OPTS "\
--color=fg:#c0caf5,bg:-1,hl:#2ac3de \
--color=fg+:#c0caf5,bg+:#283457,hl+:#2ac3de \
--color=gutter:-1,border:#27a1b9,separator:#ff9e64,scrollbar:#27a1b9 \
--color=info:#545c7e,prompt:#2ac3de,pointer:#ff007c,marker:#ff007c,spinner:#ff007c \
--color=header:#ff9e64,query:#c0caf5:regular"
