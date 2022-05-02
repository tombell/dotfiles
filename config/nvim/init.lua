require "tombell.globals"

if require "tombell.first_load"() then
  return
end

vim.g.mapleader = ","

vim.g.sql_type_default = "pgsql"

-- Ruby files load slow if you don't set this when using rbenv
vim.g.ruby_path = "$HOME/.rbenv/shims"

require "tombell.plugins"
require "tombell.mappings"
require "tombell.autocmd"
