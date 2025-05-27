return {
  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup {
        automatic_enable = {
          exclude = { "solargraph" },
        },
        ensure_installed = {
          "gopls",
          "lua_ls",
          "solargraph",
          "tailwindcss",
          "vtsls",
        },
      }

      vim.lsp.config("sourcekit", { filetypes = { "swift" } })
      vim.lsp.config("vtsls", {
        settings = {
          typescript = { preferences = { importModuleSpecifier = "non-relative" } },
          javascript = { preferences = { importModuleSpecifier = "non-relative" } },
        },
      })

      vim.lsp.enable("solargraph", vim.fs.find(".solargraph.yml", { path = vim.uv.cwd(), upward = true })[1] ~= nil)
    end,
  },

  -- mason.nvim
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {},
      ui = {
        border = "rounded",
        backdrop = 100,
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      local mr = require "mason-registry"

      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger {
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          }
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
