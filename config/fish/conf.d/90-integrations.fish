status --is-interactive; or return

if type -q mise
    mise activate fish | source
end

if type -q zoxide
    zoxide init fish | source
end

if type -q tendr
    tendr completion fish | source
end
