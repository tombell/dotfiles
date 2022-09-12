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
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

if vim.fn.executable "gopls" then
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
end

if vim.fn.executable "tailwindcss-language-server" == 1 then
  lspconfig.tailwindcss.setup {
    filetypes = { "css", "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

if vim.fn.executable "typescript-language-server" == 1 then
  lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
