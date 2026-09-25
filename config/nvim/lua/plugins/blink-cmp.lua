return {
  src = "https://github.com/saghen/blink.cmp",
  version = vim.version.range "1.*",
  data = {
    setup = function()
      require("blink.cmp").setup {
        sources = {
          default = { "lazydev", "lsp", "buffer", "snippets", "path" },
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
