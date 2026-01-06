return {
  src = "https://github.com/saghen/blink.cmp",
  version = vim.version.range "1.*",
  data = {
    setup = function()
      require("blink.cmp").setup {
        completion = {
          ghost_text = { enabled = false },
        },
        keymap = {
          preset = "enter",
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
        },
        signature = { enabled = false },
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
      }
    end,
  },
}
