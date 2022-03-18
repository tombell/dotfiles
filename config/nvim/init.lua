local cmd = vim.cmd
local g = vim.g
local o = vim.o

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

cmd [[source ~/.config/nvim/packages.vim]]

cmd [[filetype plugin indent on]]

g.mapleader = ','

o.backspace = [[indent,eol,start]]
o.backup = false
o.writebackup = false
o.swapfile = false
o.history = 50
o.ruler = true
o.showcmd = true
o.incsearch = true
o.hlsearch = false
o.laststatus = 2
o.autowrite = true
o.title = true
o.cmdheight = 2
o.shortmess = 'filtIoOA'
o.termguicolors = true
o.hidden = true

cmd [[syntax on]]
o.background = "dark"
cmd [[colorscheme sonokai]]

g.is_posix = 1

o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true

o.list = true
o.listchars = [[tab:»·,trail:·,nbsp:·]]

o.joinspaces = false

o.textwidth = 80
o.colorcolumn = '+1'

o.number = true
o.numberwidth = 4

o.wildmode = [[list:longest,list:full]]

g.html_indent_tags = "li|p"

o.splitbelow = true
o.splitright = true

map('i', '<c-space>', '<c-x><c-o>')

o.completeopt = "menu"

map('n', '<leader>a', ':cclose<bar>:lclose<cr>')

map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-l>', '<c-w>l')

map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

map('n', 'Q', 'gqap')
map('v', 'Q', 'gq')

map('n', '<c-p>', ':Files<cr>', { silent = true })

g.fzf_preview_window = {}
g.fzf_layout = { down = "20%" }

g.sql_type_default = "pgsql"

map('i', '<cr>', 'pumvisible() ? coc#_select_confirm() : "\\<c-g>u\\<cr>"', {
  expr = true,
  silent = true,
})
