return {
  -- tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        comments = { italic = false },
      },
      on_highlights = function(highlights, colors)
        highlights.Folded = { fg = colors.blue0 }
        highlights.WinSeparator = { fg = colors.bg_visual }
        highlights.SnacksIndentScope = { fg = colors.blue0 }
      end,
    },
    init = function()
      vim.cmd.colorscheme "tokyonight-night"
    end,
  },
}
