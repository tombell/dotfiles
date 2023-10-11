return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "bash",
          "c",
          "css",
          "diff",
          "embedded_template",
          "git_config",
          "git_rebase",
          "go",
          "gomod",
          "html",
          "javascript",
          "json",
          "latex",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "scss",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
      }
    end,
  },
}
