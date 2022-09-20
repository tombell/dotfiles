local packer = require "packer"

packer.startup(function()
  use "wbthomason/packer.nvim"

  use "gpanders/editorconfig.nvim"

  use "stevearc/dressing.nvim"

  use {
    "lukas-reineke/virt-column.nvim",
    config = function()
      require "tombell.plugins.virt-column"
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
    "nvim-telescope/telescope.nvim",
    config = function()
      require "tombell.plugins.telescope"
    end,
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
  }

  use {
    "nvim-lualine/lualine.nvim",
    config = function()
      require "tombell.plugins.lualine"
    end,
  }

  use {
    "numToStr/Comment.nvim",
    config = function()
      require "tombell.plugins.comment"
    end,
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  }
end)
