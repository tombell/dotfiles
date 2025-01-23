if vim.env.PROF then
  local snacks = vim.fn.stdpath "data" .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  ---@diagnostic disable: missing-fields
  require("snacks.profiler").startup {
    startup = { event = "VimEnter" },
  }
end

_G.tombell = require "util"

require("config.lazy").load()
