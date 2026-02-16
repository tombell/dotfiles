vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("tombell-ruby-format", {}),
  callback = function()
    vim.lsp.buf.format()
  end,
})
