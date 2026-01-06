return {
  src = "https://github.com/nvim-lualine/lualine.nvim",
  data = {
    setup = function()
      require("lualine").setup {
        sections = {
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { { "lsp_status", icon = "" }, "encoding", "fileformat", "filetype" },
        },
      }
    end,
  },
}
