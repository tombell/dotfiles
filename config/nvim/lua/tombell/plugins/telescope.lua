local imap = require("tombell.keymap").imap
local nmap = require("tombell.keymap").nmap

local telescope = require "telescope"
local actions = require "telescope.actions"
local builtin = require "telescope.builtin"
local themes = require "telescope.themes"

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
    builtin.find_files(themes.get_ivy {
      find_command = { "rg", "--files", "--glob", "!.git/*" },
      previewer = false,
      hidden = true,
    })
  end,
}

nmap {
  "<Leader>p",
  function()
    builtin.find_files(themes.get_ivy {
      previewer = false,
      no_ignore = true,
    })
  end,
}
