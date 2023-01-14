require "tombell.globals"

if require "tombell.first_load"() then
  return
end

vim.g.mapleader = ","

require "tombell.plugins"
require "tombell.autocmd"
