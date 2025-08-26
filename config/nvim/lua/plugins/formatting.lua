return {
  -- conform.nvim
  {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      format_on_save = {
        timeout_ms = 3000,
      },
      formatters_by_ft = {
        bash = { "shfmt" },
        go = { "goimports", "gofumpt" },
        javascript = { "prettier", lsp_format = "fallback" },
        javascriptreact = { "prettier", lsp_format = "fallback" },
        json = { "prettier", lsp_format = "fallback" },
        jsonc = { "prettier", lsp_format = "fallback" },
        lua = { "stylua" },
        sh = { "shfmt" },
        swift = { "swift_format" },
        typescript = { "prettier", lsp_format = "fallback" },
        typescriptreact = { "prettier", lsp_format = "fallback" },
        zig = { "zigfmt" },
      },
      formatters = {
        prettier = {
          condition = function(_, ctx)
            return vim.fs.find({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.js",
              "prettier.config.js",
              ".prettierrc.mjs",
              "prettier.config.mjs",
              ".prettierrc.cjs",
              "prettier.config.cjs",
              ".prettierrc.toml",
            }, { path = ctx.filename, upward = true })[1] ~= nil
          end,
        },
      },
    },
  },

  -- mason.nvim
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "gofumpt",
        "goimports",
        "prettier",
        "shfmt",
        "stylua",
      },
    },
  },
}
