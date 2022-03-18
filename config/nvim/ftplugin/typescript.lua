local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.o.signcolumn = 'number'

vim.cmd [[autocmd FileType qf setlocal wrap]]

map('n', '<leader>r', '<Plug>(coc-rename)', { noremap = false })

opts = { noremap = false, silent = true }

map('n', 'gd', '<Plug>(coc-definition)', opts)
map('n', 'gy', '<Plug>(coc-type-definition)', opts)
map('n', 'gi', '<Plug>(coc-implementation)', opts)
map('n', 'gr', '<Plug>(coc-references)', opts)

map('n', 'qf', '<Plug>(coc-fix-current)', { noremap = false })
