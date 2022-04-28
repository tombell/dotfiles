vim.api.nvim_create_autocmd("BufWinLeave", {
  callback = function()
    vim.wo.spell = false
  end,
})
