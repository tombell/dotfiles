local M = {}

function M.setup()
  require "tombell.config.options"
  require "tombell.config.autocmds"
  require "tombell.config.keymaps"

  require("lazy").setup({
    { import = "tombell.plugins" },
    { import = "tombell.plugins.lang" },
  }, {
    install = {
      colorscheme = { "catppuccin" },
    },
    ui = {
      backdrop = 100,
    },
    change_detection = {
      notify = false,
    },
  })
end

return M
