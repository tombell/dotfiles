_G.tombell = require "tombell.util"

local M = {}

tombell.config = M

M.ui = {
  foldend = {
    exclude = {
      "markdown",
      "python",
      "skbdrc",
      "tex",
      "yaml",
    },
  },
}

M.icons = {
  diagnostics = {
    error = "",
    warn = "",
    hint = "",
    info = "",
  },
}

function M.setup()
  require "tombell.config.options"
  require "tombell.config.autocmds"
  require "tombell.config.keymaps"

  require("lazy").setup({
    { import = "tombell.plugins" },
  }, {
    install = {
      colorscheme = { "tokyonight-night" },
    },
    ui = {
      backdrop = 100,
      border = "rounded",
    },
    change_detection = {
      notify = false,
    },
  })
end

return M
