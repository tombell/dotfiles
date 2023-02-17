local configs = require "nvim-treesitter.configs"

configs.setup {
  ensure_installed = {
    "bash",
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
  highlight = { enable = true },
  indent = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
