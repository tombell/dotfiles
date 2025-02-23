return {
  -- conform.nvim
  {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      format_on_save = {
        timeout_ms = 3000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        lua = { "stylua" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
      },
      formatters = {
        -- prettierd = {
        --   condition = function(_, ctx)
        --     return vim.fs.find({
        --       ".prettierrc",
        --       ".prettierrc.json",
        --       ".prettierrc.yml",
        --       ".prettierrc.yaml",
        --       ".prettierrc.js",
        --       "prettier.config.js",
        --       ".prettierrc.mjs",
        --       "prettier.config.mjs",
        --       ".prettierrc.cjs",
        --       "prettier.config.cjs",
        --       ".prettierrc.toml",
        --     }, { path = ctx.filename, upward = true })[1] ~= nil
        --   end,
        -- },
      },
    },
  },

  -- mason.nvim
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gofumpt",
        "goimports",
        "prettierd",
        "stylua",
      },
    },
  },
}
