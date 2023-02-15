local packer = require "packer"

packer.startup(function()
  use "wbthomason/packer.nvim"

  use "stevearc/dressing.nvim"

  use {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup { show_current_context = true }
    end,
  }

  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require "tombell.plugins.catppuccin"
    end,
  }

  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup()
    end,
  }

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  }

  use {
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
  }

  use {
    "nvim-telescope/telescope.nvim",
    config = function()
      require "tombell.plugins.telescope"
    end,
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }

  use {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  }

  use {
    "rafaelsq/nvim-goc.lua",
    config = function()
      require("nvim-goc").setup()
    end,
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require "tombell.plugins.treesitter"
    end,
  }

  use {
    "neovim/nvim-lspconfig",
    config = function()
      require "tombell.plugins.lsp.servers"
    end,
  }

  use {
    "hrsh7th/nvim-cmp",
    config = function()
      require "tombell.plugins.lsp.cmp"
    end,
    requires = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "roobert/tailwindcss-colorizer-cmp.nvim",
    },
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "tombell.plugins.lsp.null-ls"
    end,
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }

  use {
    "lukas-reineke/virt-column.nvim",
    config = function()
      require("virt-column").setup()
    end,
  }
end)
