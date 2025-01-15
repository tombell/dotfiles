local M = setmetatable({}, {
  __call = function(m, ...)
    return m.telescope(...)
  end,
})

function M.telescope(builtin, opts)
  require("telescope.builtin")[builtin](opts)
end

return M
