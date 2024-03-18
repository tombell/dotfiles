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
    { import = "tombell.plugins.lang.templ" },
    { import = "tombell.plugins.lang.typescript" },
  }, {
    install = {
      colorscheme = { "rose-pine" },
    },
  })

  vim.cmd.colorscheme "rose-pine"
end

return M
