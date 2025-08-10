return {
  -- tokyonight.nvim
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(highlights, colors)
        highlights.Folded = { fg = colors.blue0 }
        highlights.WinSeparator = { fg = colors.bg_visual }
        highlights.SnacksIndentScope = { fg = colors.blue0 }
        -- highlights.SnacksPicker = { bg = colors.bg }
        -- highlights.SnacksPickerBorder = { fg = colors.border_highlight, bg = colors.bg }
        -- highlights.SnacksPickerBoxTitle = { fg = colors.orange, bg = colors.bg }
        -- highlights.SnacksPickerInputTitle = { fg = colors.orange, bg = colors.bg }
        -- highlights.SnacksPickerInputBorder = { fg = colors.orange, bg = colors.bg }
      end,
    },
    init = function()
      vim.cmd.colorscheme "tokyonight-night"
    end,
  },
}
