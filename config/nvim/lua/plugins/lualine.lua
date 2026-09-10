return {
  src = "https://github.com/nvim-lualine/lualine.nvim",
  data = {
    setup = function()
      local jj = require "util.jj"

      require("lualine").setup {
        sections = {
          lualine_b = {
            {
              jj.status,
              icon = "",
              cond = function()
                return jj.root() ~= nil
              end,
            },
            {
              "branch",
              cond = function()
                return jj.root() == nil
              end,
            },
            "diff",
            "diagnostics",
          },
          lualine_c = { { "filename", path = 1 } },
        },
      }
    end,
  },
}
