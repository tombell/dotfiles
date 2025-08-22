vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("tombell-formatoptions", { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove { "o" }
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("tombell-highlight-yaml", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("tombell-close-with-q", { clear = true }),
  pattern = {
    "checkhealth",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "qf",
    "query",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.iter(vim.lsp.get_clients()):each(function(client)
      client:stop()
    end)
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("tombell-lsp-attach", { clear = true }),
  callback = function(event)
    local function map(lhs, rhs, desc, mode, o)
      mode = mode or "n"
      o = o or { buffer = event.buf, desc = desc }
      vim.keymap.set(mode, lhs, rhs, o)
    end

    -- stylua: ignore start
    map("<leader>cl", "<cmd>LspInfo<cr>", "LSP Info")
    map("gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
    map("gr", function() Snacks.picker.lsp_references() end, "References")
    map("gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
    map("gy", function() Snacks.picker.lsp_type_definitions() end, "Goto Type Definition")
    map("<leader>ss", function() Snacks.picker.lsp_symbols() end, "LSP Symbols")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("K", vim.lsp.buf.hover, "Hover")
    map("gK", vim.lsp.buf.signature_help, "Signature Help")
    map("<c-k>", vim.lsp.buf.signature_help, "Signature Help", "i")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
    map("<leader>cc", vim.lsp.codelens.run, "Run Codelens", { "n", "v" })
    map("<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens", "n")
    map("<leader>cR", function() Snacks.rename.rename_file() end, "Rename File", "n")
    map("<leader>cr", vim.lsp.buf.rename, "Rename")
    map("]]", function() Snacks.words.jump(vim.v.count1) end, "Next Reference")
    map("[[", function() Snacks.words.jump(-vim.v.count1) end, "Prev Reference")
    -- stylua: ignore end
  end,
})
