set -gx HOMEBREW_NO_ASK 1
set -gx HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS 1

if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv fish | source
end
