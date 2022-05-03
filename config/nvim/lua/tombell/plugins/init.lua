local packer = require "packer"

packer.startup(function()
  use "wbthomason/packer.nvim"

  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require "tombell.plugins.catppuccin"
    end,
  }

  use "gpanders/editorconfig.nvim"

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
      require "tombell.plugins.lspconfig"
    end,
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "tombell.plugins.null_ls"
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
      "nvim-telescope/telescope-ui-select.nvim",
    },
  }

  use "JoosepAlviste/nvim-ts-context-commentstring"

  use {
    "numToStr/Comment.nvim",
    config = function()
      require "tombell.plugins.comment"
    end,
  }

  use "lifepillar/pgsql.vim"

  use "mattn/vim-goaddtags"
end)
