vim.lsp.log.set_level "ERROR"

vim.lsp.config("gopls", {
  settings = {
    gopls = { gofumpt = true },
  },
})

local filetypes = vim.tbl_filter(function(ft)
  return ft ~= "eruby"
end, vim.lsp.config["tailwindcss"].filetypes)

vim.lsp.config("tailwindcss", {
  filetypes = filetypes,
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
  "oxlint",
  "rubocop",
  "ruby_lsp",
  "sourcekit",
  "tailwindcss",
  "vtsls",
}
