vim.filetype.add {
  pattern = {
    -- dotenv files
    [".env.*"] = "sh",
    -- skbd config files
    ["skbdrc"] = "skbdrc",
  },
}
