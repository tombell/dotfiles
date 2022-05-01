local catppuccin = require "catppuccin"

catppuccin.setup {
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = "italic",
        hints = "italic",
        warnings = "italic",
        information = "italic",
      },
      underlines = {
        errors = "underline",
        hints = "underline",
        warnings = "underline",
        information = "underline",
      },
    },
    telescope = true,
    markdown = true,
  },
}

vim.cmd [[colorscheme catppuccin]]

vim.cmd [[highlight VertSplit guifg=#302D41]]
