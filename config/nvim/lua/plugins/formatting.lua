return {
  -- conform.nvim
  {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
        javascript = { "biome", "biome-organize-imports", "prettier" },
        javascriptreact = { "biome", "biome-organize-imports", "prettier" },
        json = { "biome", "prettier" },
        jsonc = { "biome", "prettier" },
        lua = { "stylua" },
        typescript = { "biome", "biome-organize-imports", "prettier" },
        typescriptreact = { "biome", "biome-organize-imports", "prettier" },
      },
      formatters = {
        biome = {
          condition = function(_, ctx)
            return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        ["biome-organize-imports"] = {
          condition = function(_, ctx)
            return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        prettier = {
          condition = function(_, ctx)
            return not vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
