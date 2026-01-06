return {
  src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  data = {
    setup = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          "gofumpt",
          "goimports",
          "gopls",
          "lua-language-server",
          "prettier",
          "rubocop",
          "ruby-lsp",
          "shfmt",
          "stylua",
          "vtsls",
          "zls",
        },
      }
    end,
  },
}
