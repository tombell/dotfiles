local o = vim.o

-- Enable tree-sitter based folding
o.foldlevel = 20
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
