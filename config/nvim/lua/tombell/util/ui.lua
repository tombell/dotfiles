local M = {}

function M.statuscolumn()
  return table.concat {
    "%l",
    " ",
    "%s",
    require("pleat").fold(),
    "  ",
  }
end

return M
