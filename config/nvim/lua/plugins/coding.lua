return {
  -- blink.cmp
  {
    "saghen/blink.cmp",
    version = "v1.*",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "enter",
        ["<tab>"] = { "select_next", "fallback" },
        ["<s-tab>"] = { "select_prev", "fallback" },
      },
      signature = { enabled = false },
      completion = {
        list = {
          selection = { preselect = false, auto_insert = true },
        },
      },
      cmdline = { enabled = false },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },

  -- lazydev.nvim
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },

  -- ts-comments.nvim
  {
    "folke/ts-comments.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {},
  },

  -- applescript.vim
  {
    "vim-scripts/applescript.vim",
    ft = "applescript",
  },
}
