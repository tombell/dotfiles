local lspconfig = require "lspconfig"

local U = require "tombell.plugins.lsp.utils"

local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 200,
}

local capabilities = U.capabilities()

local on_attach = function(client, buf)
  U.disable_formatting(client)
  U.mappings(buf)
end

vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

local servers = { "gopls", "tsserver", "tailwindcss" }

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
  }
end
