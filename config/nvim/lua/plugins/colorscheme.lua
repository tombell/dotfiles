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
      end,
    },
    -- init = function()
    --   vim.cmd.colorscheme "tokyonight-night"
    -- end,
  },

  -- vague.nvim
  {
    "vague2k/vague.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(highlights)
        highlights.Folded = { bg = "#252530", fg = "#8ba9c1" }
        highlights.WinSeparator = { fg = "#1c1c24" }
        highlights.SnacksIndentScope = { fg = "#c9b1ca" }
      end,
    },
    init = function()
      vim.cmd.colorscheme "vague"
    end,
  },
}
