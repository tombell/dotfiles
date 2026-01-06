return {
  src = "https://github.com/folke/trouble.nvim",
  data = {
    setup = function()
      require("trouble").setup()

      -- stylua: ignore start
      vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Todo (Trouble)" })
      vim.keymap.set("n", "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", { desc = "Todo/Fix/Fixme (Trouble)" })
      ---@diagnostic disable-next-line: undefined-field
      vim.keymap.set("n", "<leader>st", function() Snacks.picker.todo_comments() end, { desc = "Todo" })
      ---@diagnostic disable-next-line: undefined-field
      vim.keymap.set("n", "<leader>sT", function() Snacks.picker.todo_comments { keywords = { "TODO", "FIX", "FIXME" } } end, { desc = "Todo/Fix/Fixme" })
      -- stylua: ignore end

      -- stylua: ignore start
      vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
      vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
      vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols (Trouble)" })
      vim.keymap.set("n", "<leader>cS", "<cmd>Trouble lsp toggle<cr>", { desc = "LSP references/definitions/... (Trouble)" })
      vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
      vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
      -- stylua: ignore end
    end,
  },
}
