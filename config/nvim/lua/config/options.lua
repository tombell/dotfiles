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

o.showmode = false

o.splitbelow = true
o.splitright = true

o.number = true

o.wrap = false
o.linebreak = true
o.showbreak = "↳  "

o.signcolumn = "yes"
o.statuscolumn = "%!v:lua.require'util'.ui.statuscolumn()"

o.foldlevel = 99
o.foldmethod = "expr"
o.foldexpr = "v:lua.require'util'.ui.foldexpr()"
o.foldtext = "v:lua.require'pleat'.get()"

o.fillchars:append "fold: "
