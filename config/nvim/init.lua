require('map')
require('plugins')

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.cmd('filetype plugin indent on')

vim.g.mapleader = ','

vim.o.backspace = 'indent,eol,start'
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

vim.cmd('syntax on')
vim.o.background = 'dark'
vim.cmd('colorscheme sonokai')

vim.g.is_posix = 1

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.list = true
vim.o.listchars = 'tab:»·,trail:·,nbsp:·'

vim.o.joinspaces = false

vim.o.textwidth = 80
vim.o.colorcolumn = '+1'

vim.o.number = true
vim.o.numberwidth = 4

vim.o.wildmode = 'list:longest,list:full'

vim.g.html_indent_tags = 'li|p'

vim.o.splitbelow = true
vim.o.splitright = true

vim.map('i', '<c-space>', '<c-x><c-o>')

vim.o.completeopt = 'menu'

vim.map('n', '<leader>a', ':cclose<bar>:lclose<cr>')

vim.map('n', '<c-j>', '<c-w>j')
vim.map('n', '<c-k>', '<c-w>k')
vim.map('n', '<c-h>', '<c-w>h')
vim.map('n', '<c-l>', '<c-w>l')

vim.map('n', 'n', 'nzzzv')
vim.map('n', 'N', 'Nzzzv')

vim.map('n', 'Q', 'gqap')
vim.map('v', 'Q', 'gq')

vim.map('n', '<c-p>', ':Files<cr>', { silent = true })

vim.g.fzf_preview_window = {}
vim.g.fzf_layout = { down = '20%' }

vim.g.sql_type_default = 'pgsql'

map('i', '<cr>', 'pumvisible() ? coc#_select_confirm() : "\\<c-g>u\\<cr>"', {
  expr = true,
  silent = true,
})
