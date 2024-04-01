return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "git_config",
        "git_rebase",
        "html",
        "json",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "scss",
        "skbdrc",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    main = "nvim-treesitter.configs",
    dependencies = {
      "starkwm/tree-sitter-skbdrc",
    },
  },

  {
    "starkwm/tree-sitter-skbdrc",
    config = true,
  },
}
