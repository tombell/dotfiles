if require "core.first_load"() then
  return
end

require "core.globals"
require "core.plugins"
require "core.options"
require "core.mappings"
require "core.autocmd"
