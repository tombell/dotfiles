local M = {}

function M.on_attach(_, buffer)
  -- stylua: ignore start
  vim.keymap.set("n", "<leader>cl", vim.cmd.LspInfo, { desc = "Lsp Info", buffer = buffer })
  vim.keymap.set("n", "gd", function() require("telescope.builtin").lsp_definitions { reuse_win = true } end, { desc = "Goto Definition", buffer = buffer })
  vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "References", buffer = buffer })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration", buffer = buffer })
  vim.keymap.set("n", "gI", function() require("telescope.builtin").lsp_implementations { reuse_win = true } end, { desc = "Goto Implementation", buffer = buffer })
  vim.keymap.set("n", "gy", function() require("telescope.builtin").lsp_type_definitions { reuse_win = true } end, { desc = "Goto T[y]pe Definiton", buffer = buffer })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover", buffer = buffer })
  vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help", buffer = buffer })
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename", buffer = buffer })
  vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", buffer = buffer })
  vim.keymap.set("n", "<leader>cA", function()
    vim.lsp.buf.code_action {
      context = {
        only = {
          "source",
        },
      },
    }
  end, { desc = "Source Action", buffer = buffer })
  -- stylua: ignore end
end

return M
