return {
  src = "https://github.com/tombell/pleat.nvim",
  data = {
    setup = function()
      vim.g.pleat_opts = {
        foldend_exclude_filetypes = {
          "dosini",
          "markdown",
          "python",
          "skbdrc",
          "tex",
          "toml",
          "yaml",
        },
      }

      vim.o.foldtext = "v:lua.require'pleat'.get()"
    end,
  },
}
