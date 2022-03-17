# Set the default FZF command to use ripgrep
FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Set the default FZF options
FZF_DEFAULT_OPTS='--height 20%'

# Set the FZF color scheme to dracula
FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#9ed072,fg+:-1,bg+:-1,hl+:#f39660
--color=info:#b39df3,prompt:#9ed072,pointer:#fc5d7c,marker:#fc5d7c,spinner:#fc5d7c
'

export -U FZF_DEFAULT_COMMAND FZF_DEFAULT_OPTS
