require "core.globals"

if require "core.first_load"() then
  return
end

vim.g.mapleader = ","

vim.g.sql_type_default = "pgsql"

-- Ruby files load slow if you don't set this when using rbenv
vim.g.ruby_path = "$HOME/.rbenv/shims"

require "core.plugins"
require "core.options"
require "core.mappings"
require "core.autocmd"
