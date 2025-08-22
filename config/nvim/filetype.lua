vim.filetype.add {
  extension = {
    skbd = "skbdrc",
  },
  pattern = {
    -- dotenv files
    [".env.*"] = "sh",

    -- skbd config files
    ["skbdrc"] = "skbdrc",
  },
}
