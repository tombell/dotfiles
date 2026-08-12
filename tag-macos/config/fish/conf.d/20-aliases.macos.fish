status --is-interactive; or return

alias ds='find . -name ".DS_Store" -type f -delete'
alias safe='xattr -r -d com.apple.quarantine'

alias bl='brew list -1 --formula'
alias blc='brew list -1 --cask'

function bd --description 'Show dependencies for Homebrew leaves'
    brew leaves | xargs brew deps --formula --for-each | sed "s/^.*:/"(tput setaf 4)"&"(tput sgr0)"/"
end

function bup --description 'Update and clean up Homebrew'
    brew update
    and brew upgrade
    and brew cleanup -s --prune=all
end
