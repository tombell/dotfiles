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
g.sonokai_style = "atlantis"
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
o.numberwidth = 5

o.wildmode = [[list:longest,list:full]]

cmd [[
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

g.html_indent_tags = "li|p"

o.splitbelow = true
o.splitright = true

map('i', '<C-space>', '<C-x><C-o>')

o.completeopt = "menu"

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

g.fzf_preview_window = {}
g.fzf_layout = { down = "20%" }

g.sql_type_default = "pgsql"
