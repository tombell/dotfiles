require "config.options"
require "config.autocmds"
require "config.keymaps"

local gh = function(x)
  return "https://github.com/" .. x
end

vim.pack.add({
  -- dependencies
  { src = gh "nvim-lua/plenary.nvim" },
  { src = gh "nvim-neotest/nvim-nio" },

  -- misc
  { src = gh "neovim/nvim-lspconfig" },

  -- treesitter
  require "plugins.treesitter",

  -- ai
  require "plugins.opencode",

  -- coding
  require "plugins.blink-cmp",
  require "plugins.lazydev",
  require "plugins.ts-comments",

  -- colorscheme
  require "plugins.tokyonight",

  -- editor
  require "plugins.gitsigns",
  require "plugins.nvim-colorizer",
  require "plugins.todo-comments",
  require "plugins.trouble",
  require "plugins.which-key",

  -- formatting
  require "plugins.conform",

  -- linting
  require "plugins.nvim-lint",

  -- mason
  require "plugins.mason",
  require "plugins.mason-tool-installer",

  -- testing
  { src = gh "Arthur944/neotest-bun" },
  { src = gh "fredrikaverpil/neotest-golang" },
  { src = gh "zidhuss/neotest-minitest" },
  { src = gh "marilari88/neotest-vitest" },
  require "plugins.neotest",

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

require("vim._core.ui2").enable {
  enable = true,
  msg = {
    target = "cmd",
    timeout = 4000,
  },
}
