require("packer").startup(function()
  use "wbthomason/packer.nvim"

  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = 'require("core.plugins.catppuccin")',
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }

  use "editorconfig/editorconfig-vim"
  use "tpope/vim-commentary"

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = 'require("core.plugins.treesitter")',
  }

  use {
    "neovim/nvim-lspconfig",
    config = 'require("core.plugins.lsp")',
  }

  use "lifepillar/pgsql.vim"
end)
