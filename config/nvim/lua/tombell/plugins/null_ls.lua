local null_ls = require "null-ls"

local prefer_local = "node_modules/.bin"

null_ls.setup {
  sources = {
    -- code actions
    null_ls.builtins.code_actions.eslint.with { prefer_local = prefer_local },

    -- completion
    null_ls.builtins.completion.spell.with { filetypes = { "markdown", "gitcommit" } },

    -- diagnostics
    null_ls.builtins.diagnostics.eslint.with { prefer_local = prefer_local },
    null_ls.builtins.diagnostics.rubocop,

    -- formatting
    -- null_ls.builtins.formatting.goimports,
    -- null_ls.builtins.formatting.gofmt,
    -- null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.stylua,
  },

  on_attach = function(client, bufnr)
    if client.resolved_capabilities.document_formatting then
      local null_ls_group = vim.api.nvim_create_augroup("null_ls_group", { clear = true })

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = null_ls_group,
        command = "lua vim.lsp.buf.formatting_sync()",
      })
    end
  end,
}
