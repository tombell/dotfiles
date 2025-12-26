require("hem").setup {
  fold = {
    open = "",
    close = "",
  },
}

require("lualine").setup {
  sections = {
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { { "lsp_status", icon = "" }, "encoding", "fileformat", "filetype" },
  },
}

require("mini.icons").setup()

require("pleat").setup {
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

require("snacks").setup {
  indent = {
    animate = { enabled = false },
  },
  input = { enabled = true },
  picker = {
    layout = "vertical",
    sources = {
      files = {
        hidden = true,
        follow = true,
      },
    },
  },
  toggle = { notify = false },
  words = {
    modes = { "n", "c" },
  },
}
