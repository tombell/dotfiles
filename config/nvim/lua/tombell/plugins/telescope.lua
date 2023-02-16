local nmap = require("tombell.keymap").nmap

local telescope = require "telescope"
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--glob", "!.git/*" },
      hidden = true,
      previewer = false,
    },
  },
}

nmap { "<C-p>", builtin.find_files }
nmap { "<C-g>", builtin.live_grep }
nmap { "<Leader>f", builtin.grep_string }
