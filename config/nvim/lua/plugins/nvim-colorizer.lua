return {
  src = "https://github.com/catgoose/nvim-colorizer.lua",
  data = {
    setup = function()
      require("colorizer").setup {
        user_default_options = {
          names = false,
          css = true,
          -- tailwind = true,
          mode = "virtualtext",
          virtualtext_inline = "before",
        },
      }
    end,
  },
}
