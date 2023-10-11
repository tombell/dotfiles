return {
  --
  -- Improved vim.ui
  --

  {
    "stevearc/dressing.nvim",
    lazy = true,
  },

  --
  -- Statusline
  --

  {
    "nvim-lualine/lualine.nvim",
    opts = {},
  },

  --
  -- Indent guides
  --

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
