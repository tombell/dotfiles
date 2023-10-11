vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("spell_group", { clear = true }),
  pattern = { "markdown", "gitcomit" },
  command = "setlocal spell",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*" },
  command = "normal zx",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = {
    ".env",
    ".env.development",
    ".env.e2e",
    ".env.local",
    ".env.production",
    ".env.staging",
    ".env.test",
  },
  command = "setlocal ft=sh",
})
