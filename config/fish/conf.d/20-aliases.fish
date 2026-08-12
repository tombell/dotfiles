status --is-interactive; or return

alias l='ls -lAh'
alias ll='ls -al'
alias la='ls -A'

alias ..='cd ..'
alias ...='cd ../..'

if type -q bat
    alias cat='bat --paging=never'
end

if type -q mise
    alias mup='mise upgrade'
end
