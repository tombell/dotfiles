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
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    main = "nvim-treesitter.configs",
  },
}
