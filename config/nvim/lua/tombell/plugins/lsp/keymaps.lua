local M = {}

function M.on_attach(_, buffer)
  local map = function(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = buffer, desc = desc })
  end

  -- stylua: ignore start
  map("<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
  map("gd", function() require("telescope.builtin").lsp_definitions { reuse_win = true } end, "Goto Definition")
  map("gr", function() require("telescope.builtin").lsp_references { reuse_win = true } end, "References")
  map("gI", function() require("telescope.builtin").lsp_implementations { reuse_win = true } end, "Goto Implementation")
  map("gy", function() require("telescope.builtin").lsp_type_definitions { reuse_win = true } end,"Goto T[y]pe Definition")
  map("gD", vim.lsp.buf.declaration, "Goto Declaration")
  map("K", vim.lsp.buf.hover, "Hover")
  map("gK", vim.lsp.buf.signature_help, "Signature Help")
  map("<c-k>", vim.lsp.buf.signature_help, "Signature Help", "i")
  map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
  map("<leader>cc", vim.lsp.codelens.run, "Run Codelens", { "n", "v" })
  map("<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens", "n")
  map("<leader>cr", vim.lsp.buf.rename, "Rename")
  -- stylua: ignore end
end

return M
