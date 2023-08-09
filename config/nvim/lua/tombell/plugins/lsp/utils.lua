local nmap = require("tombell.keymap").nmap

local U = {}

function U.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  return capabilities
end

function U.disable_formatting(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = true
end

function U.mappings(buf)
  vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")

  opts = { buffer = buf }

  nmap { "gd", require("telescope.builtin").lsp_definitions, opts }
  nmap { "gy", require("telescope.builtin").lsp_type_definitions, opts }
  nmap { "gi", require("telescope.builtin").lsp_implementations, opts }
  nmap { "gr", require("telescope.builtin").lsp_references, opts }

  nmap { "K", vim.lsp.buf.hover, opts }

  nmap {
    "[d",
    function()
      vim.diagnostic.goto_prev { float = false }
    end,
    opts,
  }
  nmap {
    "]d",
    function()
      vim.diagnostic.goto_next { float = false }
    end,
    opts,
  }

  nmap { "<leader>a", vim.lsp.buf.code_action, opts }
  nmap { "<leader>r", vim.lsp.buf.rename, opts }
end

function U.fmt_on_save(client, buf)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("FORMATTING", { clear = true }),
      buffer = buf,
      callback = function()
        vim.lsp.buf.format { timeout_ms = 3000, buffer = buf }
      end,
    })
  end
end

return U
