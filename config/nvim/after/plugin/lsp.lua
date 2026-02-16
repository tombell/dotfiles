vim.lsp.log.set_level "ERROR"

vim.lsp.config("gopls", {
  settings = {
    gopls = { gofumpt = true },
  },
})

-- NOTE: https://github.com/folke/lazydev.nvim/issues/136
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
})

vim.lsp.config("vtsls", {
  settings = {
    typescript = { preferences = { importModuleSpecifier = "non-relative" } },
    javascript = { preferences = { importModuleSpecifier = "non-relative" } },
  },
})

vim.lsp.enable { "gopls", "lua_ls", "rubocop", "ruby_lsp", "sourcekit", "vtsls", "zls" }
