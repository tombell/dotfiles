require("mason").setup {
  ui = { backdrop = 100 },
}

require("mason-tool-installer").setup {
  ensure_installed = {
    "gofumpt",
    "goimports",
    "golangci-lint",
    "gopls",
    "lua-language-server",
    "prettier",
    "shfmt",
    "stylua",
    "vtsls",
    "zls",
  },
}
