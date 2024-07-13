alias l="ls -lAh"
alias ll="ls -al"
alias la="ls -A"

alias e="nvim"

alias path='echo $PATH | tr -s ":" "\n"'

alias d="cd ~/.dotfiles"

alias bl="brew list -1 --formula"
alias blc="brew list -1 --cask"
alias bd="brew leaves | xargs brew deps --formula --for-each | sed \"s/^.*:/$(tput setaf 4)&$(tput sgr0)/\""

alias todo="rg -F 'TODO'"

alias urepo='for d in *; do (cd $d && pwd && git pull && echo); done'
alias brepo='for d in *; do (cd "$d" && pwd && git branch && echo); done'

alias ds='find . -name ".DS_Store" -type f -delete'

alias safe='xattr -r -d com.apple.quarantine'

alias fuckoffruby="ps aux | rg ruby | awk '{print \$2}' | xargs -n1 kill -9 || true"
alias fuckoffpuma="ps aux | rg puma | awk '{print \$2}' | xargs -n1 kill -9 || true"
