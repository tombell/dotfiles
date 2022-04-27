require("plugins")

vim.cmd('filetype plugin indent on')

vim.g.mapleader = ','

vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.history = 50
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.title = true
vim.opt.cmdheight = 2
vim.opt.shortmess = 'filtIoOA'
vim.opt.termguicolors = true
vim.opt.hidden = true

vim.cmd('syntax on')
vim.opt.background = 'dark'
vim.cmd('colorscheme catppuccin')

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.list = true
vim.opt.listchars = { tab = '»·', trail = '·', nbsp = '·' }

vim.opt.joinspaces = false

vim.opt.textwidth = 80
vim.opt.colorcolumn = '+1'

vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'number'

vim.opt.completeopt = 'menu'

vim.opt.wildmode = { list = 'longest', list = 'full' }

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

vim.keymap.set('i', '<tab>', 'InsertTabWrapper()', { expr = true })
vim.keymap.set('i', '<s-tab>', '<c-n>')

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.keymap.set('i', '<c-space>', '<c-x><c-o>', { noremap = false })

vim.keymap.set('n', '<leader>a', ':cclose<bar>:lclose<cr>', { silent = true })

vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-l>', '<c-w>l')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', 'Q', 'gqap')
vim.keymap.set('v', 'Q', 'gq')

vim.keymap.set('n', '<c-p>', ':Files<cr>', { silent = true })

vim.g.fzf_preview_window = {}
vim.g.fzf_layout = { down = '20%' }

vim.g.is_posix = 1

vim.g.html_indent_tags = 'li|p'

vim.g.sql_type_default = 'pgsql'

vim.g.ruby_path = '$HOME/.rbenv/shims'
