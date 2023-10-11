return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require "lspconfig"

      vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

      local servers = {
        "gopls",
        "solargraph",
        "sourcekit",
        "tsserver",
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      for _, server in ipairs(servers) do
        lspconfig[server].setup {
          capabilities = capabilities,
          on_attach = function(client, buf)
            vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")

            opts = { buffer = buf }

            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

            vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, opts)
            vim.keymap.set("n", "gy", require("telescope.builtin").lsp_type_definitions, opts)
            vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, opts)
            vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)

            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

            vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
          end,
        }
      end
    end,
  },
}
