# Set the default FZF command to use ripgrep
FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Set the default FZF options
FZF_DEFAULT_OPTS='--height 20%'

# Set the FZF color scheme to dracula
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD
--color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96
--color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD
'

export -U FZF_DEFAULT_COMMAND FZF_DEFAULT_OPTS
