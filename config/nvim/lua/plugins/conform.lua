return {
  src = "https://github.com/stevearc/conform.nvim",
  data = {
    setup = function()
      local formatters_by_ft = {
        bash = { "shfmt" },
        css = { "oxfmt" },
        fish = { "fish_indent" },
        go = { "goimports" },
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
        typescript = { "oxfmt" },
        typescriptreact = { "oxfmt" },
        yaml = { "oxfmt" },
      }

      if vim.fn.executable "nixfmt" == 1 then
        formatters_by_ft.nix = { "nixfmt" }
      end

      require("conform").setup {
        format_on_save = { timeout_ms = 1500 },
        formatters_by_ft = formatters_by_ft,
      }
    end,
  },
}
