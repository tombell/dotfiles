_G.tombell = require "tombell.util"

local M = {}

function M.setup()
  require "tombell.config.options"

  ---@type LazyConfig
  local opts = {
    spec = {
      { import = "tombell.plugins" },
    },
    install = {
      colorscheme = { "tokyonight-night" },
    },
    dev = {
      path = "~/Code/tombell",
      patterns = { "tombell" },
      fallback = true,
    },
    ui = {
      backdrop = 100,
    },
  }

  require("lazy").setup(opts)

  require "tombell.config.autocmds"
  require "tombell.config.keymaps"
end

return M
