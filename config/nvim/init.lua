vim.loader.enable()

require "config.options"
require "config.autocmds"
require "config.commands"
require "config.keymaps"

vim.pack.add({
  -- dependencies
  { src = "https://github.com/nvim-lua/plenary.nvim" },

  -- misc
  { src = "https://github.com/neovim/nvim-lspconfig" },

  -- editor
  require "plugins.gitsigns",
  require "plugins.nvim-colorizer",
  require "plugins.todo-comments",
  require "plugins.trouble",
  require "plugins.which-key",

  -- treesitter
  require "plugins.treesitter",

  -- coding
  require "plugins.blink-cmp",
  require "plugins.lazydev",
  require "plugins.ts-comments",

  -- colorscheme
  require "plugins.tokyonight",

  -- mason
  require "plugins.mason",
  require "plugins.mason-tool-installer",

  -- formatting
  require "plugins.conform",

  -- ui
  require "plugins.hem",
  require "plugins.lualine",
  require "plugins.mini-icons",
  require "plugins.pleat",
  require "plugins.snacks",
}, {
  load = function(plug)
    local data = plug.spec.data or {}
    local setup = data.setup

    vim.cmd.packadd(plug.spec.name)

    if setup ~= nil and type(setup) == "function" then
      setup()
    end
  end,
})

-- NOTE: this is an experimental feature
-- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/_core/ui2.lua
require("vim._core.ui2").enable {
  enable = true,
  msg = {
    targets = "msg",
    timeout = 4000,
  },
}
