return {
  -- hem.nvim
  {
    "tombell/hem.nvim",
    dev = true,
    event = "VeryLazy",
    opts = {},
  },

  -- lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      theme = "tokyonight",
    },
  },

  -- mini.icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- pleat.nvim
  {
    "tombell/pleat.nvim",
    dev = true,
    event = "VeryLazy",
    init = function()
      local o = vim.opt

      o.foldlevel = 99
      o.foldmethod = "expr"
      o.foldexpr = "v:lua.require'util'.ui.foldexpr()"
      o.foldtext = "v:lua.require'pleat'.get()"

      o.fillchars:append "fold: "
    end,
  },

  -- snacks.nvim
  {
    "folke/snacks.nvim",
    opts = {
      indent = {
        scope = { enabled = false },
      },
      input = { enabled = true },
      toggle = { notify = false },
      words = { enabled = true },
    },
  },
}
