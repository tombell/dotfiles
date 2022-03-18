local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.o.signcolumn = 'number'

vim.cmd [[autocmd FileType qf setlocal wrap]]

map('n', '<leader>r', '<Plug>(coc-rename)', { noremap = false })

map('n', 'gd', '<Plug>(coc-definition)', { noremap = false, silent = true })
map('n', 'gy', '<Plug>(coc-type-definition)', { noremap = false, silent = true })
map('n', 'gi', '<Plug>(coc-implementation)', { noremap = false, silent = true })
map('n', 'gr', '<Plug>(coc-references)', { noremap = false, silent = true })
