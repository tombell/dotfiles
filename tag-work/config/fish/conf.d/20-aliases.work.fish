status --is-interactive; or return

function c --description 'Launch Claude and reset the terminal afterward'
    claude
    and tput reset
end

alias rw='railway'
