return {
  -- blink.cmp
  {
    "saghen/blink.cmp",
    version = "v0.*",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "enter",
        ["<tab>"] = { "select_next", "fallback" },
        ["<s-tab>"] = { "select_prev", "fallback" },
      },
      signature = { enabled = true },
      completion = {
        list = {
          selection = { preselect = false, auto_insert = true },
        },
      },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        cmdline = {},
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
      },
    },
  },

  -- ts-comments.nvim
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
