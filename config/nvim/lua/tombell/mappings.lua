local imap = require("tombell.keymap").imap
local nmap = require("tombell.keymap").nmap

imap {
  "<Tab>",
  function()
    local col = vim.fn.col "." - 1

    if col == 0 or vim.fn.getline("."):sub(col, col):match "%s" then
      return "<Tab>"
    end

    return "<C-p>"
  end,
  { expr = true },
}

imap { "<S-Tab>", "<C-n>" }

nmap { "<Leader>c", ":cclose|:lclose<CR>", { silent = true } }

nmap { "<C-j>", "<C-w>j" }
nmap { "<C-k>", "<C-w>k" }
nmap { "<C-h>", "<C-w>h" }
nmap { "<C-l>", "<C-w>l" }

nmap { "n", "nzzzv" }
nmap { "N", "Nzzzv" }

nmap { "Q", "gqap" }
nmap { "Q", "gq" }
