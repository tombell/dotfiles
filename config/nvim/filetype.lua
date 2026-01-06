vim.filetype.add {
  extension = {
    ["jbuilder"] = "ruby",
  },
  pattern = {
    -- dotenv files
    [".env.*"] = "sh",
    -- skbd config files
    ["skbdrc"] = "skbdrc",
  },
}
