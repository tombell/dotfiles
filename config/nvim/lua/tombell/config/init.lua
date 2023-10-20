local M = {}

function M.setup()
  require "tombell.config.options"
  require "tombell.config.autocmd"
  require "tombell.config.keymaps"

  require("lazy").setup { import = "tombell/plugins" }

  vim.cmd.colorscheme "catppuccin"
end

return M
