local U = require "tombell.plugins.lsp.utils"

local null_ls = require "null-ls"

local sources = {
  null_ls.builtins.formatting.gofmt,
  null_ls.builtins.formatting.goimports,
  null_ls.builtins.formatting.prettier.with {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  null_ls.builtins.formatting.stylua,
}

-- if vim.fn.filereadable ".rubocop.yml" == 1 then
--   table.insert(sources, null_ls.builtins.diagnostics.rubocop)
-- end

null_ls.setup {
  sources = sources,
  on_attach = function(client, buf)
    U.fmt_on_save(client, buf)
  end,
}
