local imap = require("tombell.keymap").imap
local nmap = require("tombell.keymap").nmap

local U = {}

local fmt_group = vim.api.nvim_create_augroup("FORMATTING", { clear = true })

function U.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  return require("cmp_nvim_lsp").default_capabilities(capabilities)
end

function U.disable_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = true
end

function U.mappings(buf)
  vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")

  nmap { "gd", vim.lsp.buf.definition, { buffer = buf } }
  nmap { "gy", vim.lsp.buf.type_definition, { buffer = buf } }
  nmap { "gi", vim.lsp.buf.implementation, { buffer = buf } }
  nmap { "gr", vim.lsp.buf.references, { buffer = buf } }

  nmap { "K", vim.lsp.buf.hover, { buffer = buf } }

  nmap { "<Leader>a", vim.lsp.buf.code_action, { buffer = buf } }
  nmap { "<Leader>r", vim.lsp.buf.rename, { buffer = buf } }
end

function U.fmt_on_save(client, buf)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = fmt_group,
      buffer = buf,
      callback = function()
        vim.lsp.buf.format { timeout_ms = 3000, buffer = buf }
      end,
    })
  end
end

return U
