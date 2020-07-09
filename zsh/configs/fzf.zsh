# Set the default FZF command to use ripgrep
FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Set the default FZF options
FZF_DEFAULT_OPTS='--height 25%'

export -U FZF_DEFAULT_COMMAND FZF_DEFAULT_OPTS

