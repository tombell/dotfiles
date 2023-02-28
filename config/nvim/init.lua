if vim.g.vscode then
  vim.keymap.set({ "n", "o", "x" }, "gc", "<Plug>VSCodeCommentary", { remap = true })
  vim.keymap.set("n", "gcc", "<Plug>VSCodeCommentaryLine", { remap = true })
  return
end

require "tombell.globals"

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

vim.g.mapleader = ","

require "tombell.plugins"
require "tombell.autocmd"
