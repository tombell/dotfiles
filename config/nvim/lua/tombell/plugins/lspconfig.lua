local lspconfig = require "lspconfig"

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = false,
})

local on_attach = function(client, bufnr)
  local opts = { buffer = 0 }

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", opts)

  vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

  vim.keymap.set("n", "<Leader>a", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, opts)

  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

  if client.resolved_capabilities.document_formatting then
    vim.keymap.set("n", "<Leader>f", vim.lsp.buf.formatting, opts)
  elseif client.resolved_capabilities.document_range_formatting then
    vim.keymap.set("n", "<Leader>f", vim.lsp.buf.formatting, opts)
  end

  vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local servers = { "sourcekit", "tsserver" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.gopls.setup {
  settings = {
    gopls = {
      analyses = {
        nilness = true,
        shadow = true,
        unusedparams = true,
        useany = true,
      },
      staticcheck = true,
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.solargraph.setup {
  cmd = { "bundle", "exec", "solargraph", "stdio" },
  settings = {
    diagnostics = true,
  },
  on_attach = on_attach,
  capabilities = capabilities,
}
