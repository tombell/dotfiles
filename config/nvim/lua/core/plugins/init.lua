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

  -- lsp
  use {
    "neovim/nvim-lspconfig",
    config = 'require("core.plugins.lsp")',
  }

  -- javascript/typescript
  use "HerringtonDarkholme/yats.vim"
  use "pangloss/vim-javascript"
  use "MaxMEllon/vim-jsx-pretty"

  -- toml
  use "cespare/vim-toml"

  -- swift
  use "keith/swift.vim"

  -- sql
  use "lifepillar/pgsql.vim"

  -- css
  use "hail2u/vim-css3-syntax"
end)
