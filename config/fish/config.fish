# Sagittarius A syntax and completion colours.
set -g fish_color_normal F4D9C4
set -g fish_color_command F2B49D
set -g fish_color_keyword D59AAA
set -g fish_color_quote B6C99B
set -g fish_color_redirection 8DBDE0
set -g fish_color_end D59AAA
set -g fish_color_error E39494
set -g fish_color_param F4D9C4
set -g fish_color_option 8DBDE0
set -g fish_color_comment 9B8294
set -g fish_color_selection F4D9C4 --background=302536
set -g fish_color_operator C5A5AD
set -g fish_color_escape FFF1C2
set -g fish_color_autosuggestion 9B8294
set -g fish_color_valid_path --underline
set -g fish_color_search_match FFF1C2 --background=302536
set -g fish_color_history_current --bold
set -g fish_color_cancel E39494

set -g fish_pager_color_progress F4D9C4 --background=302536
set -g fish_pager_color_prefix F2B49D --bold
set -g fish_pager_color_completion F4D9C4
set -g fish_pager_color_description C5A5AD
set -g fish_pager_color_selected_background --background=302536
set -g fish_pager_color_selected_prefix FFF1C2 --bold
set -g fish_pager_color_selected_completion FFF1C2
set -g fish_pager_color_selected_description F4D9C4

set -g fish_greeting

if test -f "$HOME/.local.fish"
    source "$HOME/.local.fish"
end
