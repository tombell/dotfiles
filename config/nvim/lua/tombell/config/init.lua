local M = {}

function M.setup()
  require "tombell.config.options"
  require "tombell.config.autocmd"
  require "tombell.config.keymaps"

  require("lazy").setup({
    { import = "tombell.plugins" },
    { import = "tombell.plugins.lang.go" },
    { import = "tombell.plugins.lang.ruby" },
    { import = "tombell.plugins.lang.typescript" },
    { import = "tombell.plugins.lang.javascript" },
  }, {
    install = {
      colorscheme = { "catppuccin" },
    },
  })

  vim.cmd.colorscheme "catppuccin"
end

return M
