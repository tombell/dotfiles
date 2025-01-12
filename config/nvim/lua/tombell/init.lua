_G.tombell = require "tombell.util"

local M = {}

function M.setup()
  require "tombell.config.options"

  require("lazy").setup({
    { import = "tombell.plugins" },
  }, {
    install = {
      colorscheme = { "tokyonight-night" },
    },
    ui = {
      backdrop = 100,
    },
  })

  require "tombell.config.autocmds"
  require "tombell.config.keymaps"
end

return M
