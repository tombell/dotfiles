local M = setmetatable({}, {
  __index = function(tbl, key)
    tbl[key] = require("tombell.util." .. key)
    return tbl[key]
  end,
})

function M.expand_tabs(str, ts)
  local new = str:sub(1, 0)
  local pad = " "
  local ti = 0
  local i = 0

  while true do
    i = str:find("\t", i, true)

    if not i then
      if ti == 0 then
        new = str
      else
        new = new .. str:sub(ti + 1)
      end

      break
    end

    if ti + 1 == i then
      new = new .. pad:rep(ts)
    else
      local append = str:sub(ti + 1, i - 1)

      new = new .. append .. pad:rep(ts - vim.api.nvim_strwidth(append) % ts)
    end

    ti = i
    i = i + 1
  end

  return new
end

function M.trim(str)
  return str:gsub("^%s*(.-)%s*$", "%1")
end

return M
