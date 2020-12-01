# Set the default FZF command to use ripgrep
FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Set the default FZF options
FZF_DEFAULT_OPTS='--height 25%'

# Set the FZF color scheme to dracula
FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

export -U FZF_DEFAULT_COMMAND FZF_DEFAULT_OPTS
