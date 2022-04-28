vim.cmd [[
  function! InsertTabWrapper()
    let col = col('.') - 1
    if !col
      return "\<tab>"
    endif
    let char = getline('.')[col - 1]
    if char =~ '\k'
      return "\<C-p>"
    else
      return "\<tab>"
    endif
  endfunction
]]

vim.keymap.set("i", "<Tab>", "InsertTabWrapper()", { expr = true })
vim.keymap.set("i", "<S-Tab>", "<C-n>")

vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { noremap = false })

vim.keymap.set("n", "<Leader>a", ":cclose|:lclose<CR>", { silent = true })

vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "Q", "gqap")
vim.keymap.set("v", "Q", "gq")

local find_files = require("telescope.builtin").find_files
local get_dropdown = require("telescope.themes").get_dropdown

vim.keymap.set("n", "<C-p>", function()
  find_files(get_dropdown {})
end)

vim.keymap.set("n", "<Leader>p", function()
  find_files(get_dropdown { no_ignore = true })
end)
