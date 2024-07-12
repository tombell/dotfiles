return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      notify_on_error = false,
      format_on_save = {
        async = false,
        timeout_ms = 5000,
        lsp_fallback = false,
      },
    },
  },
}
