setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal noexpandtab

let g:go_template_autocreate = 0

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

let g:go_fmt_command = 'goimports'

let g:go_jump_to_error = 0

let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['typecheck', 'golint']

autocmd BufEnter *.go nmap <leader>r  <Plug>(go-rename)
