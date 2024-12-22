local M = {}

M._keys = nil

function M.get()
  if M._keys then
    return M._keys
  end

  -- stylua: ignore
  M._keys = {
    { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
    { "gd", function() require("telescope.builtin").lsp_definitions { reuse_win = true } end, desc = "Goto Definition", has = "definition" },
    { "gr", function() require("telescope.builtin").lsp_references { reuse_win = true } end, desc = "References", nowait = true },
    { "gI", function() require("telescope.builtin").lsp_implementations { reuse_win = true } end, desc = "Goto Implementation" },
    { "gy", function() require("telescope.builtin").lsp_type_definitions { reuse_win = true } end, desc = "Goto T[y]pe Definition" },
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    { "K", vim.lsp.buf.hover, desc = "Hover" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
    { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
    { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
  }

  return M._keys
end

function M.has(buffer, method)
  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has(buffer, m) then
        return true
      end
    end

    return false
  end

  method = method:find "/" and method or "textDocument/" .. method

  local clients = vim.lsp.get_clients { bufnr = buffer }

  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end

  return false
end

function M.resolve(buffer)
  local Keys = require "lazy.core.handler.keys"

  if not Keys.resolve then
    return {}
  end

  local spec = M.get()
  local opts = tombell.opts "nvim-lspconfig"
  local clients = vim.lsp.get_clients { bufnr = buffer }

  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end

  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require "lazy.core.handler.keys"
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    local has = not keys.has or M.has(buffer, keys.has)
    local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

    if has and cond then
      local opts = Keys.opts(keys)
      opts.cond = nil
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer

      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
