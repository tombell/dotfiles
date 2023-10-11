local M = {}

function M.foldtext()
  local ok = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
  local ret = ok and vim.treesitter.foldtext and vim.treesitter.foldtext()

  if not ret or type(ret) == "string" then
    ret = { { vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1], {} } }
  end

  table.insert(ret, { "󰇘 " })

  if not vim.treesitter.foldtext then
    return table.concat(
      vim.tbl_map(function(line)
        return line[1]
      end, ret),
      " "
    )
  end
  return ret
end

function M.linenr()
  local win = vim.g.statusline_winid
  local is_num = vim.wo[win].number
  local is_relnum = vim.wo[win].relativenumber

  local lnum = ""

  if (is_num or is_relnum) and vim.v.virtnum == 0 then
    if vim.v.relnum == 0 then
      lnum = is_num and "%l" or "%r"
    else
      lnum = is_relnum and "%r" or "%l"
    end

    lnum = "%=" .. lnum .. " "
  end

  return lnum
end

function M.fold()
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

function M.statuscolumn()
  return table.concat {
    "%s",
    "%=" .. M.linenr(),
    " ",
    "%#FoldColumn#",
    M.fold(),
    "%#StatusColumnBuffer#",
    " ",
  }
end

return M
