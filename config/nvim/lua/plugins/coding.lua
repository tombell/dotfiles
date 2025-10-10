require("blink.cmp").setup({
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
})

require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "snacks.nvim", words = { "Snacks" } },
  },
})

require("ts-comments").setup()
