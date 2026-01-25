vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    local parsers = require "nvim-treesitter.parsers"

    ---@diagnostic disable: missing-fields

    parsers.applescript = {
      install_info = {
        url = "https://github.com/waddie/tree-sitter-applescript",
        queries = "queries",
      },
    }

    parsers.skbdrc = {
      install_info = {
        url = "https://github.com/starkwm/tree-sitter-skbdrc",
        queries = "queries/skbdrc",
      },
    }

    ---@diagnostic enable: missing-fields
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

require("nvim-treesitter").setup()
require("nvim-treesitter").install {
  "applescript",
  "bash",
  "c",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "editorconfig",
  "embedded_template",
  "git_config",
  "git_rebase",
  "go",
  "gomod",
  "gosum",
  "gotmpl",
  "html",
  "hyprlang",
  "ini",
  "javascript",
  "jsdoc",
  "json",
  "jsonc",
  "latex",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "objc",
  "python",
  "query",
  "regex",
  "ruby",
  "rust",
  "skbdrc",
  "sql",
  "ssh_config",
  "swift",
  "tmux",
  "toml",
  "tsx",
  "typescript",
  "vimdoc",
  "xml",
  "yaml",
  "zig",
}
