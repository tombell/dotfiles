vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = false

local go_group = vim.api.nvim_create_augroup("go_group", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = go_group,
  pattern = "*.go",
  callback = vim.lsp.buf.formatting_sync,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = go_group,
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)

    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
  end,
})
