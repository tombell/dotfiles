return {
  src = "https://github.com/folke/ts-comments.nvim",
  data = {
    setup = function()
      require("ts-comments").setup()
    end,
  },
}
