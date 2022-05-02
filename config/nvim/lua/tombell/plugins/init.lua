local packer = require "packer"

packer.startup(function()
  use "wbthomason/packer.nvim"

  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = [[require("tombell.plugins.catppuccin")]],
  }

  use "gpanders/editorconfig.nvim"

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = [[require("tombell.plugins.treesitter")]],
  }

  use {
    "neovim/nvim-lspconfig",
    config = [[require("tombell.plugins.lspconfig")]],
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = [[require("tombell.plugins.null_ls")]],
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }

  use {
    "nvim-telescope/telescope.nvim",
    config = [[require("tombell.plugins.telescope")]],
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
  }

  use "JoosepAlviste/nvim-ts-context-commentstring"

  use {
    "numToStr/Comment.nvim",
    config = [[require("tombell.plugins.comment")]],
  }

  use "lifepillar/pgsql.vim"

  use "mattn/vim-goaddtags"
end)
