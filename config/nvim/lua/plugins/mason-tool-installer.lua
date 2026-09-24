return {
  src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  data = {
    setup = function()
      local ensure_installed = {
        "alejandra",
        "gofumpt",
        "goimports",
        "gopls",
        "json-lsp",
        "lua-language-server",
        "oxfmt",
        "oxlint",
        "shfmt",
        "stylua",
        "vtsls",
      }

      if vim.fn.executable "nix" == 1 then
        table.insert(ensure_installed, "nil")
      end

      require("mason-tool-installer").setup { ensure_installed = ensure_installed }
    end,
  },
}
