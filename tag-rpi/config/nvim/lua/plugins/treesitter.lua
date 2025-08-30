vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

return {
  -- nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    opts = {
      install_dir = vim.fn.stdpath "data" .. "/site",
    },
  },
}
