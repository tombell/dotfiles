local nmap = require("tombell.keymap").nmap
local vmap = require("tombell.keymap").vmap

nmap { "<leader>c", ":cclose|:lclose<cr>", { silent = true } }

nmap { "<c-j>", "<c-w>j" }
nmap { "<c-k>", "<c-w>k" }
nmap { "<c-h>", "<c-w>h" }
nmap { "<c-l>", "<c-w>l" }

nmap { "n", "nzzzv" }
nmap { "N", "Nzzzv" }

nmap { "Q", "gqip" }
vmap { "Q", "gq" }

nmap { "<space>", "za" }
