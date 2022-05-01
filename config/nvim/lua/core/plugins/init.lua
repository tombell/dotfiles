local packer = require "packer"

packer.startup(function()
  use "wbthomason/packer.nvim"

  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = [[require("core.plugins.catppuccin")]],
  }

  use "gpanders/editorconfig.nvim"

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = [[require("core.plugins.treesitter")]],
  }

  use {
    "neovim/nvim-lspconfig",
    config = [[require("core.plugins.lspconfig")]],
  }

  use {
    "nvim-telescope/telescope.nvim",
    config = [[require("core.plugins.telescope")]],
    requires = {
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-lua/plenary.nvim",
    },
  }

  use "JoosepAlviste/nvim-ts-context-commentstring"

  use {
    "numToStr/Comment.nvim",
    config = [[require("core.plugins.comment")]],
  }

  use "lifepillar/pgsql.vim"

  use "mattn/vim-goaddtags"
end)
