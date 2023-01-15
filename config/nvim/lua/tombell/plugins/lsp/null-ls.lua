local U = require "tombell.plugins.lsp.utils"

local null_ls = require "null-ls"

local prefer_local = "node_modules/.bin"

local sources = {
  null_ls.builtins.formatting.prettier.with {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    prefer_local = prefer_local,
  },
  null_ls.builtins.formatting.gofmt,
}

if vim.fn.executable "stylua" == 1 then
  table.insert(sources, null_ls.builtins.formatting.stylua)
end

if vim.fn.executable "goimports" == 1 then
  table.insert(sources, null_ls.builtins.formatting.goimports)
end

if vim.fn.filereadable ".eslintrc.js" == 1 then
  table.insert(sources, null_ls.builtins.code_actions.eslint.with { prefer_local = prefer_local })
  table.insert(sources, null_ls.builtins.diagnostics.eslint.with { prefer_local = prefer_local })
end

if vim.fn.filereadable ".rubocop.yml" == 1 then
  table.insert(sources, null_ls.builtins.diagnostics.rubocop)
end

null_ls.setup {
  sources = sources,

  on_attach = function(client, buf)
    U.fmt_on_save(client, buf)
  end,
}
