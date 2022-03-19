vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = false

vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 0
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_generate_tags = 1

vim.g.go_template_autocreate = 0

vim.g.go_fmt_command = 'goimports'

vim.g.go_jump_to_error = 0

vim.g.go_metalinter_command = 'golangci-lint'
vim.g.go_metalinter_autosave = 1

vim.api.nvim_set_keymap('n', '<leader>r', ':GoRename<cr>', { noremap = true })
