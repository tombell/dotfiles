vim.g.mapleader = " "
vim.g.maplocalleader = " "

local o = vim.opt

o.termguicolors = true

o.backup = false
o.writebackup = false
o.swapfile = false

o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true

o.hlsearch = false

o.laststatus = 3

o.shortmess:append { W = true, I = true, c = true, C = true }

o.splitbelow = true
o.splitright = true

o.number = true

o.linebreak = true
o.showbreak = "↳  "

o.signcolumn = "yes"
o.statuscolumn = "%!v:lua.require'tombell.util'.ui.statuscolumn()"
