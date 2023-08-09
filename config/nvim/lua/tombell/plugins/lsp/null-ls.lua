local U = require "tombell.plugins.lsp.utils"

local null_ls = require "null-ls"

local sources = {
  null_ls.builtins.formatting.gofmt,
  null_ls.builtins.formatting.goimports,
  null_ls.builtins.formatting.prettierd.with {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  null_ls.builtins.formatting.stylua,
}

null_ls.setup {
  sources = sources,
  on_attach = function(client, buf)
    U.fmt_on_save(client, buf)
  end,
}
