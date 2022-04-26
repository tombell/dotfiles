vim.o.tagfunc = 'CocTagFunc'

vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })

vim.keymap.set('n', '<leader>r', '<Plug>(coc-rename)')
vim.keymap.set('n', 'qf', '<Plug>(coc-fix-current)')

vim.keymap.set('i', '<cr>', 'pumvisible() ? coc#_select_confirm() : "\\<c-g>u\\<cr>"', { expr = true })
vim.keymap.set('i', '<tab>', 'pumvisible() ? "\\<c-n>" : "\\<tab>"', { expr = true })
vim.keymap.set('i', '<s-tab>', 'pumvisible() ? "\\<c-p>" : "\\<s-tab>"', { expr = true })
