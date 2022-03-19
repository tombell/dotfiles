require('plugins')

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
vim.o.signcolumn = 'number'

vim.o.wildmode = 'list:longest,list:full'

vim.g.html_indent_tags = 'li|p'

vim.o.splitbelow = true
vim.o.splitright = true

vim.api.nvim_set_keymap('i', '<c-space>', '<c-x><c-o>', { noremap = true })

vim.o.completeopt = 'menu'

vim.api.nvim_set_keymap('n', '<leader>a', ':cclose<bar>:lclose<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<c-j>', '<c-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', { noremap = true })

vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

vim.api.nvim_set_keymap('n', 'Q', 'gqap', { noremap = true })
vim.api.nvim_set_keymap('v', 'Q', 'gq', { noremap = true })

vim.api.nvim_set_keymap('n', '<c-p>', ':Files<cr>', { silent = true })

vim.g.fzf_preview_window = {}
vim.g.fzf_layout = { down = '20%' }

vim.g.sql_type_default = 'pgsql'

vim.cmd [[
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
]]
