local configs = require "nvim-treesitter.configs"

configs.setup {
  ensure_installed = {
    "css",
    "go",
    "gomod",
    "html",
    "javascript",
    "latex",
    "lua",
    "markdown",
    "markdown_inline",
    "scss",
    "swift",
    "toml",
    "tsx",
    "typescript",
    "yaml",
  },

  sync_install = false,

  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
