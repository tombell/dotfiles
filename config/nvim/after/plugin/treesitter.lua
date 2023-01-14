local o = vim.o

-- Enable tree-sitter based folding
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
