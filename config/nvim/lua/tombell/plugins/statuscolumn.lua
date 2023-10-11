if statuscolumn then
  return
end

statuscolumn = {}

function statuscolumn.linenr()
  if vim.v.wrap then
    return ""
  end

  return vim.v.lnum
end

function statuscolumn.fold()
  if vim.v.wrap then
    return ""
  end

  local lnum = vim.v.lnum

  if vim.fn.foldlevel(lnum) <= 0 then
    return "  "
  end

  if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
    return "  "
  end

  if vim.fn.foldclosed(lnum) == -1 then
    return " "
  end

  return " "
end

vim.opt.statuscolumn = table.concat {
  "%s",
  "%=%{v:lua.statuscolumn.linenr()}",
  " ",
  "%#FoldColumn#",
  "%{v:lua.statuscolumn.fold()}",
  "%#StatusColumnBuffer#",
  " ",
}

return {}
