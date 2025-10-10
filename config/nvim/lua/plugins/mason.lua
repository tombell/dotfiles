local ensure_installed = {
  "gofumpt",
  "goimports",
  "golangci-lint",
  "gopls",
  "lua-language-server",
  "prettier",
  "shfmt",
  "solargraph",
  "stylua",
  "vtsls",
  "zls",
}

require("mason").setup {
  ui = {
    backdrop = 100,
  },
}

local mr = require "mason-registry"

mr:on("package:install:success", function()
  vim.defer_fn(function()
    vim.api.nvim_exec_autocmds("FileType", { buffer = vim.api.nvim_get_current_buf() })
  end, 100)
end)

mr.refresh(function()
  for _, tool in ipairs(ensure_installed) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end)

vim.keymap.set("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" })
