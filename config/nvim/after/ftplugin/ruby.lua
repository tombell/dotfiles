vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rb",
  callback = function()
    -- enable on-save formatting via rubocop
    -- must be defined after conform.nvim's autocmd, so that rubocop formatting runs after rubyfmt
    vim.lsp.buf.format()
  end,
})
