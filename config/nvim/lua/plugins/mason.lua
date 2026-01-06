return {
  src = "https://github.com/mason-org/mason.nvim",
  data = {
    setup = function()
      require("mason").setup {
        ui = { backdrop = 100 },
      }

      vim.keymap.set("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" })
    end,
  },
}
