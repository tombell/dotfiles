return {
  src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  data = {
    setup = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          "bash-language-server",
          "gofumpt",
          "goimports",
          "gopls",
          "lua-language-server",
          "oxfmt",
          "oxlint",
          "shfmt",
          "stylua",
          "tailwindcss-language-server",
          "vtsls",
        },
      }
    end,
  },
}
