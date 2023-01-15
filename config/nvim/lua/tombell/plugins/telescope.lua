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
}

nmap {
  "<C-p>",
  function()
    builtin.find_files {
      find_command = { "rg", "--files", "--glob", "!.git/*" },
      hidden = true,
      previewer = false,
    }
  end,
}
