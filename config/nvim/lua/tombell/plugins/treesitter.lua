local configs = require "nvim-treesitter.configs"

configs.setup {
  ensure_installed = {
    "comment",
    "css",
    "go",
    "gomod",
    "html",
    "javascript",
    "lua",
    "markdown",
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

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
