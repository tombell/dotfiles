local util = require "tombell.util"

local M = {}

M.exclude_foldend_filetypes = {
  "markdown",
  "python",
}

function M.foldtext()
  local ret = {
    util.expand_tabs(vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldstart, true)[1], vim.bo.tabstop),
    "󰇘",
  }

  if not vim.tbl_contains(M.exclude_foldend_filetypes, vim.bo.filetype) then
    local line = util.trim(vim.api.nvim_buf_get_lines(0, vim.v.foldend - 1, vim.v.foldend, true)[1])
    table.insert(ret, line)
  end

  return table.concat(ret, " ")
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
