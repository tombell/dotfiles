alias ds='find . -name ".DS_Store" -type f -delete'

alias safe='xattr -r -d com.apple.quarantine'

alias bl="brew list -1 --formula"
alias blc="brew list -1 --cask"
alias bd="brew leaves | xargs brew deps --formula --for-each | sed \"s/^.*:/$(tput setaf 4)&$(tput sgr0)/\""
alias bup="brew update && brew upgrade && brew cleanup -s --prune=all"

alias oc="opencode"
