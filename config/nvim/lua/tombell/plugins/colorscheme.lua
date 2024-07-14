return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
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
    },
    init = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
