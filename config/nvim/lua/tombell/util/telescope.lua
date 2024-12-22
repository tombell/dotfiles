local M = setmetatable({}, {
  __call = function(m, ...)
    return m.telescope(...)
  end,
})

function M.telescope(builtin, opts)
  return function()
    opts = vim.tbl_deep_extend("force", { cwd = tombell.root() }, opts or {})

    if builtin == "files" then
      opts.find_command = { "rg", "--files", "--color", "never", "--glob", "!.git/*" }
      opts.hidden = true
      builtin = "find_files"
    end

    require("telescope.builtin")[builtin](opts)
  end
end

return M
