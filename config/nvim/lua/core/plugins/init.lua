require("packer").startup(function()
  use "wbthomason/packer.nvim"

  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = [[require("core.plugins.catppuccin")]],
  }

  use {
    "nvim-telescope/telescope.nvim",
    config = [[require("core.plugins.telescope")]],
    requires = {
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-lua/plenary.nvim",
    },
  }

  use "editorconfig/editorconfig-vim"

  use {
    "numToStr/Comment.nvim",
    config = [[require("core.plugins.comment")]],
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = [[require("core.plugins.treesitter")]],
  }

  use {
    "neovim/nvim-lspconfig",
    config = [[require("core.plugins.lsp")]],
  }

  use "lifepillar/pgsql.vim"
end)
