local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system { "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath }
  vim.fn.system { "git", "-C", lazypath, "checkout", "tags/stable" }
end

vim.opt.rtp:prepend(lazypath)

local M = {}

function M.load()
  require "config.options"

  ---@type LazyConfig
  local opts = {
    spec = {
      { import = "plugins" },
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

  require "config.autocmds"
  require "config.keymaps"
end

return M
