status --is-interactive; or return

# alias l='ls -lAh'
# alias ll='ls -al'
# alias la='ls -A'

alias l='eza -lAg --icons' # matches ls -lAh: excludes . and ..
alias ll='eza -laag --icons' # matches ls -al: includes . and ..
alias la='eza -A --icons' # matches ls -A: excludes . and ..

alias tree='eza -A --tree --icons'

alias ..='cd ..'
alias ...='cd ../..'

if type -q bat
    alias cat='bat --paging=never'
end

if type -q mise
    alias mup='mise upgrade'
end
