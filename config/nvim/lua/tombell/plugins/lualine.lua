local lualine = require "lualine"

lualine.setup {
  options = {
    theme = "catppuccin",
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
      },
    },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding" },
    lualine_y = { "filetype" },
    lualine_z = { "location" },
  },
}
