return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "editorconfig",
        "git_config",
        "git_rebase",
        "html",
        "json",
        "latex",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "scss",
        "sql",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
    main = "nvim-treesitter.configs",
  },
}
