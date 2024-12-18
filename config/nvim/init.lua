local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

if vim.env.PROF then
  local snacks = vim.fn.stdpath "data" .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup {
    startup = {
      event = "VimEnter",
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  }
end

require("tombell").setup()
