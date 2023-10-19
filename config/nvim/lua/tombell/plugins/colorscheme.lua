return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "macchiato",
      highlight_overrides = {
        mocha = function(mocha)
          return {
            Folded = { fg = mocha.blue, bg = mocha.mantle },
            VertSplit = { fg = mocha.surface0, bg = mocha.base },
          }
        end,
      },
    },
  },
}
