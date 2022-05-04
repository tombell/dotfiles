vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("spell_group", { clear = true }),
  pattern = { "markdown", "gitcomit" },
  command = "setlocal spell",
})