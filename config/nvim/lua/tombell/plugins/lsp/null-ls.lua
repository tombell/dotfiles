local U = require "tombell.plugins.lsp.utils"

local null_ls = require "null-ls"

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettierd.with {
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    },
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.diagnostics.rubocop,
  },
  on_attach = U.fmt_on_save,
}
