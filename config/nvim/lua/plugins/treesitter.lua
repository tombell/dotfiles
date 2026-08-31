return {
  src = "https://github.com/nvim-treesitter/nvim-treesitter",
  data = {
    setup = function()
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
              queries = "queries",
            },
          }
          ---@diagnostic enable: missing-fields
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function() pcall(vim.treesitter.start) end,
      })

      local treesitter = require "nvim-treesitter"
      local ensure_installed = {
        "applescript",
        "bash",
        "c",
        "cpp",
        "css",
        "desktop",
        "diff",
        "dockerfile",
        "editorconfig",
        "embedded_template",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "graphql",
        "html",
        "hyprlang",
        "ini",
        "javascript",
        "jsdoc",
        "json",
        "jsx",
        "latex",
        "liquid",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "objc",
        "python",
        "qmljs",
        "query",
        "regex",
        "ruby",
        "rust",
        "skbdrc",
        "sql",
        "ssh_config",
        "swift",
        "toml",
        "tsx",
        "typescript",
        "vimdoc",
        "xml",
        "yaml",
        "zig",
        "zsh",
      }

      treesitter.setup()

      local installed = {}
      for _, language in ipairs(treesitter.get_installed "parsers") do
        installed[language] = true
      end

      local missing = vim.tbl_filter(function(language) return not installed[language] end, ensure_installed)
      if #missing > 0 then treesitter.install(missing, { summary = true }) end
    end,
  },
}
