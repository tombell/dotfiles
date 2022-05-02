vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("spell_group", { clear = true }),
  pattern = { "markdown", "gitcomit" },
  command = "setlocal spell",
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("packer_group", { clear = true }),
  pattern = "*/nvim/lua/core/plugins/init.lua",
  command = "source <afile> | PackerCompile",
  once = false,
})
