vim.lsp.set_log_level "OFF"

if vim.fn.has "nvim-0.11" == 1 then
  vim.lsp.config("vtsls", {
    settings = {
      typescript = { preferences = { importModuleSpecifier = "non-relative" } },
      javascript = { preferences = { importModuleSpecifier = "non-relative" } },
    },
  })

  vim.lsp.enable("solargraph", vim.fs.find(".solargraph.yml", { path = vim.uv.cwd(), upward = true })[1] ~= nil)
  vim.lsp.enable { "gopls", "lua_ls", "sourcekit", "vtsls", "zls" }
end
