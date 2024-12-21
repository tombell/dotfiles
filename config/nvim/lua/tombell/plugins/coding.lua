return {
  {
    "saghen/blink.cmp",
    version = "v0.*",
    opts = {
      keymap = {
        preset = "enter",
        ["<tab>"] = { "select_next", "fallback" },
        ["<s-tab>"] = { "select_prev", "fallback" },
      },
      signature = { enabled = true },
      completion = {
        list = { selection = "auto_insert" },
      },
    },
  },

  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
