return {
  src = "https://github.com/folke/lazydev.nvim",
  data = {
    setup = function()
      require("lazydev").setup {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          { path = "snacks.nvim", words = { "Snacks" } },
        },
      }
    end,
  },
}
