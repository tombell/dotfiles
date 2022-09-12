alias l="ls -lAh"
alias ll="ls -al"
alias la="ls -A"

alias e="$VISUAL"

# pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# change into dotfiles directory
alias d="cd ~/.dotfiles"

# homebrew
alias bcu="brew cleanup -s"
alias bl="brew list -1 --formula"
alias blc="brew list -1 --cask"

# find todo comments in code
alias todo="rg -F 'TODO'"

# npm/pnpm
alias j="npx jest"
alias t="npm test"
alias tc="npx tsc --noEmit"
alias pn="pnpm"
