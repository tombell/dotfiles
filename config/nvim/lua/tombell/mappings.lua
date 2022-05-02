local tab_wrapper = function()
  local col = vim.fn.col "."
  local char = vim.fn.getline("."):sub(col - 1, col - 1)

  if char == "" or string.match(char, "%s") ~= nil then
    return "<Tab>"
  end

  return "<C-p>"
end

vim.keymap.set("i", "<Tab>", tab_wrapper, { expr = true })
vim.keymap.set("i", "<S-Tab>", "<C-n>")

vim.keymap.set("n", "<Leader>c", ":cclose|:lclose<CR>", { silent = true })

vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "Q", "gqap")
vim.keymap.set("v", "Q", "gq")

local find_files = require("telescope.builtin").find_files
local get_ivy = require("telescope.themes").get_ivy

vim.keymap.set("n", "<C-p>", function()
  find_files(get_ivy { previewer = false, hidden = true })
end)

vim.keymap.set("n", "<Leader>p", function()
  find_files(get_ivy { previewer = false, no_ignore = true })
end)
