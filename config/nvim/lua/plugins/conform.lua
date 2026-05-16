return {
  src = "https://github.com/stevearc/conform.nvim",
  data = {
    setup = function()
      require("conform").setup {
        format_on_save = { timeout_ms = 1500 },
        formatters_by_ft = {
          lua = { "stylua" },
        },
      }
    end,
  },
}
