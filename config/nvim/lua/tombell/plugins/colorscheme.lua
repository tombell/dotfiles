return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    priority = 1000,
    opts = {
      flavour = "mocha",
      highlight_overrides = {
        mocha = function(mocha)
          return {
            FloatBorder = { fg = mocha.blue, bg = mocha.none },
            Folded = { fg = mocha.blue, bg = mocha.mantle },
            NormalFloat = { fg = mocha.text, bg = mocha.none },
            WinSeparator = { fg = mocha.surface0, bg = mocha.base },
          }
        end,
      },
      integrations = {
        blink_cmp = true,
      },
    },
    -- init = function()
    --   vim.cmd.colorscheme "catppuccin"
    -- end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd.colorscheme "tokyonight-night"
    end,
  },
}
