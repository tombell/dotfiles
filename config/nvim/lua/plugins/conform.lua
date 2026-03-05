return {
  src = "https://github.com/stevearc/conform.nvim",
  data = {
    setup = function()
      require("conform").setup {
        format_on_save = {
          timeout_ms = 1500,
        },
        formatters_by_ft = {
          bash = { "shfmt" },
          css = { "oxfmt" },
          go = { "goimports", "gofumpt" },
          javascript = { "oxfmt" },
          javascriptreact = { "oxfmt" },
          json = { "oxfmt" },
          jsonc = { "oxfmt" },
          lua = { "stylua" },
          graphql = { "oxfmt" },
          markdown = { "oxfmt" },
          ruby = { lsp_format = "fallback" },
          sh = { "shfmt" },
          swift = { "swift" },
          toml = { "oxfmt" },
          typescript = { "oxfmt" },
          typescriptreact = { "oxfmt" },
          yaml = { "oxfmt" },
        },
      }
    end,
  },
}
