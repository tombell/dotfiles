status --is-interactive; or return

alias ds='find . -name ".DS_Store" -type f -delete'
alias safe='xattr -r -d com.apple.quarantine'

alias bl='brew list -1 --formula'
alias blc='brew list -1 --cask'

function bd --description 'Show dependencies for Homebrew leaves'
    brew leaves | xargs brew deps --formula --for-each | awk \
        -v name_color=(tput setaf 4) -v tap_color=(tput setaf 3) -v reset=(tput sgr0) '
        {
            i = index($0, ":")
            name = substr($0, 1, i - 1)
            deps = substr($0, i + 1)
            tap = ""
            if (split(name, parts, "/") == 3) {
                tap = parts[1] "/" parts[2]
                name = parts[3]
            }
            if (!(tap in lines) && tap != "") taps[++count] = tap
            lines[tap] = lines[tap] name_color name ":" reset deps "\n"
        }
        END {
            printf "%s", lines[""]
            for (n = 1; n <= count; n++) {
                if (n > 1 || lines[""] != "") print ""
                print tap_color taps[n] ":" reset
                printf "%s", lines[taps[n]]
            }
        }'
end

function bup --description 'Update and clean up Homebrew'
    brew update
    and brew upgrade
    and brew cleanup -s --prune=all
end
