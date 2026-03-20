vim.lsp.log.set_level "ERROR"

vim.lsp.config("gopls", {
  settings = {
    gopls = { gofumpt = true },
  },
})

vim.lsp.config("vtsls", {
  settings = {
    typescript = { preferences = { importModuleSpecifier = "non-relative" } },
    javascript = { preferences = { importModuleSpecifier = "non-relative" } },
  },
})

vim.lsp.enable {
  "gopls",
  "lua_ls",
  "rubocop",
  "ruby_lsp",
  "sourcekit",
  "tailwindcss",
  "vtsls",
}
