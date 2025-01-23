return {
  -- conform.nvim
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 5000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
        javascript = { "biome", "prettierd" },
        javascriptreact = { "biome", "prettierd" },
        json = { "biome", "prettierd" },
        lua = { "stylua" },
        typescript = { "biome", "prettierd" },
        typescriptreact = { "biome", "prettierd" },
      },
      formatters = {
        biome = {
          condition = function(_, ctx)
            return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        prettierd = {
          condition = function(_, ctx)
            return not vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
  },
}
