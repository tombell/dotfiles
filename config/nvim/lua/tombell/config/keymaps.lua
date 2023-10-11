vim.keymap.set("n", "<leader>c", ":cclose|:lclose<cr>", { silent = true })

vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "Q", "gqip")
vim.keymap.set("v", "Q", "gq")

vim.keymap.set("n", "<space>", "za")
