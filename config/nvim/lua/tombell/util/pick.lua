local M = setmetatable({}, {
  __call = function(m, ...)
    return m.wrap(...)
  end,
})

function M.open(command, opts)
  command = command ~= "auto" and command or "files"
  opts = opts or {}

  opts = vim.deepcopy(opts)

  if not opts.cwd and opts.root ~= false then
    opts.cwd = tombell.root { buf = opts.buf }
  end

  tombell.telescope(command, opts)
end

function M.wrap(command, opts)
  opts = opts or {}

  return function()
    tombell.pick.open(command, vim.deepcopy(opts))
  end
end

return M
