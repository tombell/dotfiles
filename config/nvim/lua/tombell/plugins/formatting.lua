return {
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    dependencies = { "mason.nvim" },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 5000,
        async = false,
        quiet = false,
        lsp_format = "never",
      },
    },
  },
}
