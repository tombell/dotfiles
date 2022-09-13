# Set the default FZF command to use ripgrep
FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Set the FZF color scheme
FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export -U FZF_DEFAULT_COMMAND FZF_DEFAULT_OPTS
