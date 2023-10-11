return {
  {
    "stevearc/dressing.nvim",
    lazy = true,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {},
  },

  {
    "echasnovski/mini.indentscope",
    config = function()
      require("mini.indentscope").setup {
        symbol = "▎",
        draw = {
          animation = require("mini.indentscope").gen_animation.none(),
          delay = 10,
        },
      }
    end,
  },
}
