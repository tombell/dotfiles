local goc = require "nvim-goc"
local nmap = require("tombell.keymap").nmap

goc.setup { verticalSplit = false }

nmap { "<leader>gcr", goc.Coverage }
nmap { "<Leader>gcc", goc.ClearCoverage }
