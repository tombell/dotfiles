local M = {}

setmetatable(M, {
  __index = function(tbl, key)
    tbl[key] = require("util." .. key)
    return tbl[key]
  end,
})

return M
