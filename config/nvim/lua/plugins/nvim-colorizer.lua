return {
  src = "https://github.com/catgoose/nvim-colorizer.lua",
  data = {
    setup = function()
      require("colorizer").setup {
        filetypes = { "*", "!nvim-pack" },
        options = {
          parsers = {
            css = true,
            css_fn = true,
            names = { enable = false },
          },
          display = {
            mode = "virtualtext",
            virtualtext = { position = "before" },
          },
        },
      }
    end,
  },
}
