local U = require "tombell.plugins.lsp.utils"

local lspconfig = require "lspconfig"

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

local servers = { "gopls", "solargraph", "sourcekit", "tsserver" }

for _, server in ipairs(servers) do
  lspconfig[server].setup {
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      gopls = {
        env = { GOFLAGS = "-tags=mutation" },
      },
    },
  }
end
