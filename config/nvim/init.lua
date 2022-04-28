require("plugins")
require("lsp")

vim.cmd('colorscheme catppuccin')

vim.g.mapleader = ','

vim.g.ruby_path = '$HOME/.rbenv/shims'
vim.g.sql_type_default = 'pgsql'

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cmdheight = 2
vim.opt.shortmess = 'filtIoOA'
vim.opt.termguicolors = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars = { tab = '»·', trail = '·', nbsp = '·' }

vim.opt.textwidth = 80
vim.opt.colorcolumn = '+1'

vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'number'

vim.opt.completeopt = 'menu'

vim.opt.splitbelow = true
vim.opt.splitright = true

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

vim.keymap.set('i', '<Tab>', 'InsertTabWrapper()', { expr = true })
vim.keymap.set('i', '<S-Tab>', '<C-n>')

vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { noremap = false })

vim.keymap.set('n', '<Leader>a', ':cclose|:lclose<CR>', { silent = true })

vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', 'Q', 'gqap')
vim.keymap.set('v', 'Q', 'gq')

local find_files = require('telescope.builtin').find_files
local get_dropdown = require('telescope.themes').get_dropdown

vim.keymap.set('n', '<C-p>', function() find_files(get_dropdown()) end)
