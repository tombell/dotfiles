require("tokyonight").setup({
  on_highlights = function(highlights, colors)
    highlights.Folded = { fg = colors.blue0 }
    highlights.WinSeparator = { fg = colors.bg_visual }
    highlights.SnacksIndentScope = { fg = colors.blue0 }
  end,
})

vim.cmd.colorscheme "tokyonight-night"
