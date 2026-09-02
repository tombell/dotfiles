vim.lsp.log.set_level "ERROR"

vim.lsp.config("gopls", {
  settings = {
    gopls = { gofumpt = true },
  },
})

vim.lsp.config("tailwindcss", {
  filetypes = vim.tbl_filter(function(ft)
    return ft ~= "eruby"
  end, vim.lsp.config["tailwindcss"].filetypes),
})

vim.lsp.config("vtsls", {
  settings = {
    typescript = { preferences = { importModuleSpecifier = "non-relative" } },
    javascript = { preferences = { importModuleSpecifier = "non-relative" } },
  },
})

local servers = {
  "gopls",
  "lua_ls",
  "oxlint",
  "sourcekit",
  "vtsls",
}

if vim.fn.executable "rubocop" == 1 then
  table.insert(servers, "rubocop")
end

if vim.fn.executable "ruby-lsp" == 1 then
  table.insert(servers, "ruby_lsp")
end

vim.lsp.enable(servers)
