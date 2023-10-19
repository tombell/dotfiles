local M = {}

function M.on_attach(_, buffer)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer })

  vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, { buffer = buffer })
  vim.keymap.set("n", "gy", require("telescope.builtin").lsp_type_definitions, { buffer = buffer })
  vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, { buffer = buffer })
  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { buffer = buffer })

  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = buffer })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = buffer })

  vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = buffer })
  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = buffer })
end

return M
