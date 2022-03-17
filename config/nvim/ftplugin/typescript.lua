local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.cmd [[autocmd FileType qf setlocal wrap]]

map('n', '<Leader>r', ':TsuRenameSymbol<cr>')
