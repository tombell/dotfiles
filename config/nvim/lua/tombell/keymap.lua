local M = {}

M.imap = function(t)
  vim.keymap.set("i", t[1], t[2], t[3])
end

M.nmap = function(t)
  vim.keymap.set("n", t[1], t[2], t[3])
end

return M
