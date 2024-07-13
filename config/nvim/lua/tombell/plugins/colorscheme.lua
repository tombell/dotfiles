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
            Folded = { fg = mocha.blue, bg = mocha.mantle },
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
