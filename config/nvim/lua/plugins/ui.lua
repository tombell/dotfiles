return {
  -- hem.nvim
  {
    "tombell/hem.nvim",
    dev = true,
    lazy = true,
    opts = {},
  },

  -- lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_c = { { "filename", path = 1 } },
      },
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
    lazy = true,
    opts = {
      foldend_exclude_filetypes = {
        "markdown",
        "python",
        "skbdrc",
        "tex",
        "toml",
        "yaml",
      },
    },
  },

  -- snacks.nvim
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      indent = {
        animate = { enabled = false },
      },
      input = { enabled = true },
      toggle = { notify = false },
      words = {
        modes = { "n", "c" },
      },
    },
  },
}
