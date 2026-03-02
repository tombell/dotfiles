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
          -- javascript = { "oxfmt" },
          -- javascriptreact = { "oxfmt" },
          json = { "oxfmt" },
          jsonc = { "oxfmt" },
          lua = { "stylua" },
          graphql = { "oxfmt" },
          markdown = { "oxfmt" },
          ruby = {},
          sh = { "shfmt" },
          swift = { "swift" },
          typescript = { "oxfmt" },
          typescriptreact = { "oxfmt" },
        },
      }
    end,
  },
}
