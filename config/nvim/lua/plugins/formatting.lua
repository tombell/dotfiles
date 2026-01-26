require("conform").setup {
  format_on_save = {
    -- timeout_ms = 3000,
  },
  formatters_by_ft = {
    bash = { "shfmt" },
    go = { "goimports", "gofumpt" },
    javascript = { "prettier", lsp_format = "fallback" },
    javascriptreact = { "prettier", lsp_format = "fallback" },
    json = { "prettier", lsp_format = "fallback" },
    jsonc = { "prettier", lsp_format = "fallback" },
    lua = { "stylua" },
    graphql = { "prettier" },
    ruby = { "standardrb" },
    sh = { "shfmt" },
    swift = { "swift" },
    typescript = { "prettier", lsp_format = "fallback" },
    typescriptreact = { "prettier", lsp_format = "fallback" },
    zig = { "zigfmt" },
  },
}
