local o = vim.o

-- Enable 24-bit RGB colours in the terminal
o.termguicolors = true

-- Disable backup files and swap files
o.backup = false
o.writebackup = false
o.swapfile = false

-- Disable highlighting search results
o.hlsearch = false

-- Setup the command height
o.cmdheight = 2

-- Setup the short
o.shortmess = "filtIoOA"

-- Only show statusbar for current buffer
o.laststatus = 3

-- Setup tab settings
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true

-- Enable list characters
o.list = true
o.listchars = "tab:»·,trail:·,nbsp:·"

-- Enable the text width and indicator
o.textwidth = 80
o.colorcolumn = "+1"

-- Setup line numbers and sign coloumn
o.number = true
o.signcolumn = "yes:1"

-- Enable the cursor line
o.cursorline = true

-- Setup the completion options
o.completeopt = "menu,menuone,noselect"

-- Enable intuitive splits
o.splitbelow = true
o.splitright = true
