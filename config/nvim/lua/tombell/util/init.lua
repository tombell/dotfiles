local M = {}

setmetatable(M, {
  __index = function(tbl, key)
    tbl[key] = require("tombell.util." .. key)
    return tbl[key]
  end,
})

return M
