local telescope = require "telescope"
local actions = require "telescope.actions"
local themes = require "telescope.themes"

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      themes.get_cursor { winblend = 5 },
    },
  },
}

telescope.load_extension "ui-select"
