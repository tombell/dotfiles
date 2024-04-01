local M = {}

function M.setup()
  require "tombell.config.options"
  require "tombell.config.autocmds"
  require "tombell.config.keymaps"

  require("lazy").setup({
    { import = "tombell.plugins" },
    { import = "tombell.plugins.lang.go" },
    { import = "tombell.plugins.lang.javascript" },
    { import = "tombell.plugins.lang.ruby" },
    { import = "tombell.plugins.lang.svelte" },
    { import = "tombell.plugins.lang.swift" },
    { import = "tombell.plugins.lang.typescript" },
  }, {
    install = {
      colorscheme = { "catppuccin" },
    },
    ui = {
      backdrop = 100,
    },
  })

  vim.cmd.colorscheme "catppuccin"
end

return M
