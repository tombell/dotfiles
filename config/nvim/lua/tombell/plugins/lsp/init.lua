return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require "lspconfig"

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local servers = {
        "gopls",
        "lua_ls",
        "solargraph",
        "sourcekit",
        "tsserver",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup {
          capabilities = capabilities,
          on_attach = function(client, buffer)
            require("tombell.plugins.lsp.keymaps").on_attach(client, buffer)
          end,
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        }
      end
    end,
  },
}
