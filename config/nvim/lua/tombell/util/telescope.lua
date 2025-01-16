local M = setmetatable({}, {
  __call = function(m, ...)
    return m.open(...)
  end,
})

function M.open(builtin, opts)
  require("telescope.builtin")[builtin](opts)
end

return M
