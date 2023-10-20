local M = {}

function M.foldtext()
  local ok = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
  local ret = ok and vim.treesitter.foldtext and vim.treesitter.foldtext()

  if not ret or type(ret) == "string" then
    ret = { { vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, false)[1], {} } }
  end

  table.insert(ret, { " 󰇘 " })

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
  if vim.fn.foldlevel(vim.v.lnum) > vim.fn.foldlevel(vim.v.lnum - 1) then
    if vim.fn.foldclosed(vim.v.lnum) == -1 then
      return "%#FoldColumn#"
    else
      return "%#FoldColumn#"
    end
  else
    return " "
  end
end

function M.statuscolumn()
  local foldcolumn = M.fold()
  local lnum = vim.v.lnum
  return string.format("%d %s ", lnum, foldcolumn)
end

return M
