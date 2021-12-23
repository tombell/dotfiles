local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.cmd [[source ~/.config/nvim/packages.vim]]

vim.cmd [[filetype plugin indent on]]

vim.g.mapleader = ','

vim.o.backspace = [[indent,eol,start]]
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.history = 50
vim.o.ruler = true
vim.o.showcmd = true
vim.o.incsearch = true
vim.o.hlsearch = false
vim.o.laststatus = 2
vim.o.autowrite = true
vim.o.title = true
vim.o.cmdheight = 2
vim.o.shortmess = 'filtIoOA'
vim.o.termguicolors = true
vim.o.hidden = true

vim.cmd [[syntax on]]
vim.o.background = "dark"
vim.g.sonokai_style = "atlantis"
vim.cmd [[colorscheme sonokai]]

vim.g.is_posix = 1

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.list = true
vim.o.listchars = [[tab:»·,trail:·,nbsp:·]]

vim.o.joinspaces = false

vim.o.textwidth = 80
vim.o.colorcolumn = '+1'

vim.o.number = true
vim.o.numberwidth = 5

vim.o.wildmode = [[list:longest,list:full]]

vim.cmd [[
  function! InsertTabWrapper()
    let col = col('.') - 1
    if !col
      return "\<tab>"
    endif
    let char = getline('.')[col - 1]
    if char =~ '\k'
      return "\<C-p>"
    else
      return "\<tab>"
    endif
  endfunction
]]

map('i', '<tab>', 'InsertTabWrapper()', { expr = true })
map('i', '<s-tab>', '<C-n>')

vim.g.html_indent_tags = "li|p"

vim.o.splitbelow = true
vim.o.splitright = true

map('i', '<C-space>', '<C-x><C-o>')

vim.o.completeopt = "menu"

map('n', '<Leader>a', ':cclose<Bar>:lclose<cr>')

map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-l>', '<C-w>l')

map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map('n', 'Q', 'gqap')
map('v', 'Q', 'gq')

map('n', '<C-p>', ':Files<cr>', { silent = true })

vim.g.fzf_preview_window = {}
vim.g.fzf_layout = { down = "20%" }

vim.g.sql_type_default = "pgsql"
