return {
  src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  data = {
    setup = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          "gofumpt",
          "goimports",
          "gopls",
          "json-lsp",
          "lua-language-server",
          "oxfmt",
          "oxlint",
          "shfmt",
          "stylua",
          "vtsls",
        },
      }
    end,
  },
}
