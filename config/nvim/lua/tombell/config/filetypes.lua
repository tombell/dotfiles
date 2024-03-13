vim.filetype.add {
  extension = {
    templ = "templ",
  },
  pattern = {
    -- dotenv
    [".env"] = "sh",
    [".env.*"] = "sh",

    -- go templates
    ["*.gotmpl"] = "gotmpl",
    ["*.gohtml"] = "gotmpl",
    ["*.tmpl.html"] = "gotmpl",
    ["*.tmpl.txt"] = "gotmpl",
  },
}
