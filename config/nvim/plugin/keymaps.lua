local nmap = require("tombell.keymap").nmap

local goc = require "nvim-goc"

nmap { "<Leader>c", ":cclose|:lclose<CR>", { silent = true } }

nmap { "<C-j>", "<C-w>j" }
nmap { "<C-k>", "<C-w>k" }
nmap { "<C-h>", "<C-w>h" }
nmap { "<C-l>", "<C-w>l" }

nmap { "n", "nzzzv" }
nmap { "N", "Nzzzv" }

nmap { "Q", "gqap" }
nmap { "Q", "gq" }

nmap { "<Space>", "za" }

nmap { "<Leader>gcr", goc.Coverage }
nmap { "<Leader>gcc", goc.ClearCoverage }
