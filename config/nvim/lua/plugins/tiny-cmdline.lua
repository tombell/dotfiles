return {
  src = "https://github.com/rachartier/tiny-cmdline.nvim",
  data = {
    setup = function()
      vim.o.cmdheight = 0
    end,
  },
}
