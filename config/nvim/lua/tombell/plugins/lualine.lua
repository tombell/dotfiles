local lualine = require "lualine"

lualine.setup {
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding" },
    lualine_y = { "filetype" },
    lualine_z = { "location" },
  },
}
