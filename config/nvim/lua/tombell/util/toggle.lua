local M = {}

function M.diagnostics()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

function M.inlay_hints(buf, value)
  local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

  if type(ih) == "function" then
    ih(buf, value)
  elseif type(ih) == "table" and ih.enable then
    if value == nil then
      value = not ih.is_enabled { bufnr = buf or 0 }
    end

    ih.enable(value, { bufnr = buf })
  end
end

return M
