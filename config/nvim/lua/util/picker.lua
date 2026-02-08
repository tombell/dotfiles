local function picker(fn, opts)
  return function()
    require("snacks").picker[fn](vim.tbl_extend("force", { cwd = require("util").root() }, opts or {}))
  end
end

return picker
