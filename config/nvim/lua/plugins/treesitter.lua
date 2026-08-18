return {
  src = "https://github.com/arborist-ts/arborist.nvim",
  data = {
    setup = function()
      local arborist = require "arborist"
      local plugin_root = vim.fn.fnamemodify(debug.getinfo(arborist.setup, "S").source:sub(2), ":h:h:h")

      -- Neovim's runtimepath prepend no longer moves an existing entry, so
      -- remove Arborist first to ensure its curated queries precede generated ones.
      vim.opt.runtimepath:remove(plugin_root)
      vim.opt.runtimepath:prepend(plugin_root)

      arborist.setup {
        prefer_wasm = false,
        update_cadence = "manual",
        ensure_installed = {
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
          "tmux",
          "toml",
          "tsx",
          "typescript",
          "vimdoc",
          "xml",
          "yaml",
          "zig",
          "zsh",
        },
        overrides = {
          applescript = {
            url = "https://github.com/waddie/tree-sitter-applescript",
          },
          skbdrc = {
            url = "https://github.com/starkwm/tree-sitter-skbdrc",
          },
        },
      }
    end,
  },
}
