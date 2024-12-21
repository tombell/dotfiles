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
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme "tokyonight-night"
    end,
    opts = {
      on_highlights = function(highlights, colors)
        highlights.Folded = { fg = colors.blue0, bg = colors.bg_float }
        highlights.WinSeparator = { fg = colors.blue7, bg = colors.bg }
      end,
    },
  },
}
