local catppuccin = require "catppuccin"

catppuccin.setup {}

vim.cmd "colorscheme catppuccin"

vim.api.nvim_command "highlight VertSplit guifg=#302D41"
