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
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
        javascript = { "biome", "prettierd" },
        javascriptreact = { "biome", "prettierd" },
        json = { "biome", "prettierd" },
        lua = { "stylua" },
        svelte = { "prettierd" },
        swift = { "swift_format" },
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
