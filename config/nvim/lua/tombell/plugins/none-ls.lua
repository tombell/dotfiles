return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require "null-ls"

      local sources = {
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.prettier.with {
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        },
        null_ls.builtins.formatting.stylua,
      }

      null_ls.setup {
        sources = sources,
        on_attach = function(client, buf)
          if client.supports_method "textDocument/formatting" then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("FORMATTING", { clear = true }),
              buffer = buf,
              callback = function()
                vim.lsp.buf.format { timeout_ms = 3000, buffer = buf }
              end,
            })
          end
        end,
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
