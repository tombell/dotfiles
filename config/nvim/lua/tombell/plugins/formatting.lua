return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
      format_on_save = {
        async = false,
        timeout_ms = 5000,
        lsp_fallback = false,
      },
    },
  },
}
