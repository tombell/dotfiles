require("mason").setup {
  ui = { backdrop = 100 },
}

require("mason-tool-installer").setup {
  ensure_installed = {
    "gofumpt",
    "gopls",
    "lua-language-server",
    "prettier",
    "rubocop",
    "ruby-lsp",
    "shfmt",
    "stylua",
    "tsgo",
    "zls",
  },
}
