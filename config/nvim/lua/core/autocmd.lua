vim.api.nvim_create_autocmd("BufWinLeave", {
  callback = function()
    vim.wo.spell = false
  end,
})

local PackerCompile = vim.api.nvim_create_augroup("PackerCompile", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = PackerCompile,
  pattern = "*/nvim/lua/core/plugins/init.lua",
  command = "source <afile> | PackerCompile",
  once = false,
})
