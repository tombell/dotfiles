vim.pack.add {
  { src = "https://github.com/Arthur944/neotest-bun" },
  { src = "https://github.com/NickvanDyke/opencode.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/brenoprata10/nvim-highlight-colors" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/folke/ts-comments.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/fredrikaverpil/neotest-golang" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/marilari88/neotest-vitest" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mfussenegger/nvim-lint" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/nvim-neotest/neotest" },
  { src = "https://github.com/nvim-neotest/neotest-jest" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/olimorris/neotest-rspec" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range "1.*" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/tombell/hem.nvim" },
  { src = "https://github.com/tombell/pleat.nvim" },
  { src = "https://github.com/zidhuss/neotest-minitest" },
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
require "plugins.ai"

require "config.autocmds"
require "config.keymaps.editor"
require "config.keymaps.lsp"
require "config.keymaps.testing"
