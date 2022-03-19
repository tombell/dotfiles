opts = { noremap = false, silent = true }

vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', opts)
vim.api.nvim_set_keymap('n', 'gy', '<Plug>(coc-type-definition)', opts)
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', opts)
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', opts)

vim.api.nvim_set_keymap('n', '<leader>r', '<Plug>(coc-rename)', { noremap = false })
vim.api.nvim_set_keymap('n', 'qf', '<Plug>(coc-fix-current)', { noremap = false })
