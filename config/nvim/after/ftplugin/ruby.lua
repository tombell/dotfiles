vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("tombell-ruby-format", { clear = true }),
  pattern = "*.rb",
  callback = function()
    vim.lsp.buf.format()
  end,
})
