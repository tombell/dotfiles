return {
  src = "https://github.com/catgoose/nvim-colorizer.lua",
  data = {
    setup = function()
      require("colorizer").setup {
        filetypes = { "*", "!nvim-pack" },
        user_default_options = {
          names = false,
          css = true,
          css_fn = true,
          mode = "virtualtext",
          virtualtext_inline = "before",
        },
      }
    end,
  },
}
