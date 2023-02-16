local lazy = require "lazy"

lazy.setup {
  "wbthomason/packer.nvim",

  "stevearc/dressing.nvim",

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup { show_current_context = true }
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require "tombell.plugins.catppuccin"
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup()
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  {
    "anuvyklack/pretty-fold.nvim",
    config = function()
      require("pretty-fold").setup {
        sections = {
          left = { "content", "" },
          right = { "(", "number_of_folded_lines", ")" },
        },
        fill_char = " ",
      }
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require "tombell.plugins.telescope"
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  {
    "rafaelsq/nvim-goc.lua",
    config = function()
      require("nvim-goc").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    cmd = "TSUpdate",
    config = function()
      require "tombell.plugins.treesitter"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "tombell.plugins.lsp.servers"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      require "tombell.plugins.lsp.cmp"
    end,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "roobert/tailwindcss-colorizer-cmp.nvim",
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "tombell.plugins.lsp.null-ls"
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "lukas-reineke/virt-column.nvim",
    config = function()
      require("virt-column").setup()
    end,
  },
}
