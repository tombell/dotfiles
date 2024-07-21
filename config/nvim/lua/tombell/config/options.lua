vim.g.mapleader = " "
vim.g.maplocalleader = " "

local o = vim.opt

-- Enable 24-bit RGB colours
o.termguicolors = true

-- Disable backup and swap files
o.backup = false
o.writebackup = false
o.swapfile = false

-- Setup tab settings
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true

-- Disable highlighting search results
o.hlsearch = false

-- Enable statusline for current buffer only
o.laststatus = 3

-- Setup short message
o.shortmess:append { W = true, I = true, c = true, C = true }

-- Enable cursor line
o.cursorline = true

-- Enable splitting new windows below
o.splitbelow = true

-- Enable splitting new windows to the right
o.splitright = true

-- Enable line numbers
o.number = true

-- Nicer wrapping
o.linebreak = true

-- Enable sign column
o.signcolumn = "yes"

-- Enable status column
o.statuscolumn = "%!v:lua.require'tombell.util'.ui.statuscolumn()"

-- Enable tree-sitter based folding
o.foldlevel = 99
o.foldtext = "v:lua.require'tombell.util.ui'.foldtext()"
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Setup fill characters
o.fillchars = {
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
}
