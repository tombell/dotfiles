local imap = require("tombell.keymap").imap
local nmap = require("tombell.keymap").nmap

local lspconfig = require "lspconfig"

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = false,
})

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  imap { "<C-Space>", "<C-x><C-o>", { buffer = 0 } }

  nmap { "<C-]>", vim.lsp.buf.definition, { buffer = 0 } }
  nmap { "gy", vim.lsp.buf.type_definition, { buffer = 0 } }
  nmap { "gi", vim.lsp.buf.implementation, { buffer = 0 } }
  nmap { "gr", vim.lsp.buf.references, { buffer = 0 } }

  nmap { "K", vim.lsp.buf.hover, { buffer = 0 } }

  nmap { "<Leader>a", vim.lsp.buf.code_action, { buffer = 0 } }
  nmap { "<Leader>r", vim.lsp.buf.rename, { buffer = 0 } }

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
