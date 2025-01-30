return {
  -- conform.nvim
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    event = "VeryLazy",
    opts = {
      format_on_save = true,
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
