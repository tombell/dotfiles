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
    opts = function()
      return {
        symbol = "▎",
        draw = {
          animation = require("mini.indentscope").gen_animation.none(),
          delay = 10,
        },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "lazy",
          "neotest-summary",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
