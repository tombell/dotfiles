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
              queries = "queries/skbdrc",
            },
          }
          ---@diagnostic enable: missing-fields
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          if pcall(vim.treesitter.start) then
            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[0][0].foldmethod = "expr"

            -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      require("nvim-treesitter").setup()
      require("nvim-treesitter").install {
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
        -- TODO: https://github.com/hankthetank27/tree-sitter-liquid?tab=readme-ov-file#usage-in-neovim-with-nvim-treesitter
        "liquid",
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
        "zsh",

        -- external
        "applescript",
        "skbdrc",
      }
    end,
  },
}
