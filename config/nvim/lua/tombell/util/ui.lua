local M = {}

function M.statuscolumn()
  return table.concat {
    "%l",
    " ",
    "%s",
    require("pleat.ui").fold(),
    "  ",
  }
end

return M
