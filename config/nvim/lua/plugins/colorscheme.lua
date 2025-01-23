return {
  -- tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(highlights, colors)
        highlights.Folded = { fg = colors.blue0, bg = colors.bg_float }
        highlights.WinSeparator = { fg = colors.bg_visual, bg = colors.bg }
      end,
    },
    init = function()
      vim.cmd.colorscheme "tokyonight-night"
    end,
  },
}
