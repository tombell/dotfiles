require('map')

vim.o.signcolumn = 'number'

vim.cmd('autocmd FileType qf setlocal wrap')

map('n', '<leader>r', '<Plug>(coc-rename)', { noremap = false })

opts = { noremap = false, silent = true }

map('n', 'gd', '<Plug>(coc-definition)', opts)
map('n', 'gy', '<Plug>(coc-type-definition)', opts)
map('n', 'gi', '<Plug>(coc-implementation)', opts)
map('n', 'gr', '<Plug>(coc-references)', opts)
