vim.pack.add {
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/brenoprata10/nvim-highlight-colors",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/folke/trouble.nvim",
  "https://github.com/folke/ts-comments.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/fredrikaverpil/neotest-golang",
  "https://github.com/haydenmeade/neotest-jest",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/marilari88/neotest-vitest",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/olimorris/neotest-rspec",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/tombell/hem.nvim",
  "https://github.com/tombell/pleat.nvim",
  "https://github.com/zidhuss/neotest-minitest",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range "1.*" },
}

require "config.options"

require "plugins.colorscheme"
require "plugins.treesitter"
require "plugins.ui"
require "plugins.editor"
require "plugins.coding"
require "plugins.mason"
require "plugins.linting"
require "plugins.formatting"
require "plugins.testing"

require "config.autocmds"
require "config.keymaps"
