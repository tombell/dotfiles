local packer = require "packer"

packer.startup(function()
  use "wbthomason/packer.nvim"

  use "gpanders/editorconfig.nvim"

  use "stevearc/dressing.nvim"

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
