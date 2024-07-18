local M = {}

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

function M.foldtext()
  local ret = {
    M.expand_tabs(vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldstart, true)[1], vim.bo.tabstop),
    "󰇘",
  }

  if not vim.tbl_contains(tombell.config.ui.foldend.exclude, vim.bo.filetype) then
    local line = vim.api.nvim_buf_get_lines(0, vim.v.foldend - 1, vim.v.foldend, true)[1]:gsub("^%s*(.-)%s*$", "%1")
    table.insert(ret, line)
  end

  return table.concat(ret, " ")
end

function M.fold()
  if vim.fn.foldlevel(vim.v.lnum) > vim.fn.foldlevel(vim.v.lnum - 1) then
    if vim.fn.foldclosed(vim.v.lnum) == -1 then
      return "%#FoldColumn#"
    end

    return "%#FoldColumn#"
  end

  return " "
end

function M.statuscolumn()
  return string.format("%d %s ", vim.v.lnum, M.fold())
end

return M
