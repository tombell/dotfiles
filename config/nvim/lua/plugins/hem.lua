return {
  src = "https://github.com/tombell/hem.nvim",
  data = {
    setup = function()
      vim.g.hem_opts = {
        fold = {
          open = "",
          close = "",
        },
      }

      vim.o.statuscolumn = "%!v:lua.require'hem'.get()"
    end,
  },
}
