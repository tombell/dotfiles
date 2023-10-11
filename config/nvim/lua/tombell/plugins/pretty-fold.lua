return {
  {
    "anuvyklack/pretty-fold.nvim",
    opts = {
      sections = {
        left = { "content", "" },
        right = { "(", "number_of_folded_lines", ")" },
      },
      fill_char = " ",
    },
    keys = {
      { "<space>", "za" },
    },
  },
}
