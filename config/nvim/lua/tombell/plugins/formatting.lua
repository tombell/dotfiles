return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        lua = { "stylua" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
      },
    },
  },
}
