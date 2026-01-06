local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

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

o.shortmess:append { I = true }

o.showmode = false

o.splitbelow = true
o.splitright = true

o.number = true

o.wrap = false
o.linebreak = true
o.showbreak = "↳  "
o.mousescroll = "ver:3,hor:0"

o.signcolumn = "yes"

o.foldlevel = 99
o.foldmethod = "indent"

o.fillchars:append "fold: "

o.winborder = "rounded"
