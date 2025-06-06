vim.lsp.config("vtsls", {
  settings = {
    typescript = { preferences = { importModuleSpecifier = "non-relative" } },
    javascript = { preferences = { importModuleSpecifier = "non-relative" } },
  },
})

vim.lsp.enable "gopls"
vim.lsp.enable "lua_ls"
vim.lsp.enable("solargraph", vim.fs.find(".solargraph.yml", { path = vim.uv.cwd(), upward = true })[1] ~= nil)
vim.lsp.enable "tailwindcss"
vim.lsp.enable "vtsls"
