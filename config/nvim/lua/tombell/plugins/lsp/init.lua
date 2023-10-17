return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require "lspconfig"

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      for _, server in ipairs { "gopls", "solargraph", "sourcekit", "tsserver" } do
        lspconfig[server].setup {
          capabilities = capabilities,
          on_attach = function(client, buf)
            require("tombell.plugins.lsp.keymaps").on_attach(client, buffer)
          end,
        }
      end
    end,
  },
}
