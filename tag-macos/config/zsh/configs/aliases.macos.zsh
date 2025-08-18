alias ds='find . -name ".DS_Store" -type f -delete'

alias safe='xattr -r -d com.apple.quarantine'

alias bup="brew upgrade && brew cleanup -s --prune=all"

alias bl="brew list -1 --formula"
alias blc="brew list -1 --cask"
alias bd="brew leaves | xargs brew deps --formula --for-each | sed \"s/^.*:/$(tput setaf 4)&$(tput sgr0)/\""
