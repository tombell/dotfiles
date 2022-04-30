require("packer").startup(function()
  -- packer
  use "wbthomason/packer.nvim"

  -- colorscheme
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = 'require("core.plugins.catppuccin")',
  }

  -- fuzzy finding
  use {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- utilities
  use "editorconfig/editorconfig-vim"
  use "tpope/vim-commentary"

  -- highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = 'require("core.plugins.treesitter")',
  }

  -- lsp
  use {
    "neovim/nvim-lspconfig",
    config = 'require("core.plugins.lsp")',
  }

  -- sql
  use "lifepillar/pgsql.vim"
end)
