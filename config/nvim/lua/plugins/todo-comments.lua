return {
  src = "https://github.com/folke/todo-comments.nvim",
  data = {
    setup = function()
      require("todo-comments").setup()

      -- stylua: ignore start
      vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next Todo Comment" })
      vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous Todo Comment" })
      -- stylua: ignore end
    end,
  },
}
