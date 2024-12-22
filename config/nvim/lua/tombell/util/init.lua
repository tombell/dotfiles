local M = {}

setmetatable(M, {
  __index = function(tbl, key)
    tbl[key] = require("tombell.util." .. key)
    return tbl[key]
  end,
})

function M.get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

function M.opts(name)
  local plugin = M.get_plugin(name)

  if not plugin then
    return {}
  end

  local Plugin = require "lazy.core.plugin"
  return Plugin.values(plugin, "opts", false)
end

return M
