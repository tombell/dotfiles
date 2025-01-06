local M = {}

function M.fold()
  return vim.api.nvim_win_call(vim.g.statusline_winid, function()
    if vim.fn.foldclosed(vim.v.lnum) >= 0 then
      return vim.opt.fillchars:get().foldclose
    elseif tostring(vim.treesitter.foldexpr(vim.v.lnum)):sub(1, 1) == ">" then
      return vim.opt.fillchars:get().foldopen
    else
      return " "
    end
  end)
end

function M.statuscolumn()
  return table.concat {
    "%l",
    " ",
    "%s",
    M.fold(),
    "  ",
  }
end

return M
