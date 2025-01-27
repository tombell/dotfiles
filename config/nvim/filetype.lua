vim.filetype.add {
  pattern = {
    -- dotenv files
    [".env.*"] = "sh",

    -- go text/template
    [".*%.tmpl%.txt"] = "gotmpl",
    [".*%.txt%.tmpl"] = "gotmpl",

    -- go html/template
    [".*%.tmpl%.html"] = "gotmpl",
    [".*%.html%.tmpl"] = "gotmpl",
  },
}
