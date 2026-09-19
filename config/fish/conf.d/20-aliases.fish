status --is-interactive; or return

# alias l 'ls -lAh'
# alias ll 'ls -al'
# alias la 'ls -A'

alias l 'eza -lAg' # matches ls -lAh: excludes . and ..
alias ll 'eza -laag' # matches ls -al: includes . and ..
alias la 'eza -A' # matches ls -A: excludes . and ..

alias tree 'eza -A --tree'

alias .. 'cd ..'
alias ... 'cd ../..'

if type -q bat
    alias cat='bat --paging=never'
end

if type -q mise
    alias mup='mise upgrade'
end

alias ppath 'printf "%s\n" $PATH'
