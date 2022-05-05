require "tombell.globals"

if require "tombell.first_load"() then
  return
end

vim.g.mapleader = ","

-- Ruby files load slow if you don't set this when using rbenv
vim.g.ruby_path = "/Users/tombell/.rbenv/shims/ruby"

require "tombell.plugins"
require "tombell.autocmd"
