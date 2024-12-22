return {
  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      vim.diagnostic.config {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = ",",
          },
        },
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("tombell-lsp-attach", { clear = true }),
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if client then
            require("tombell.plugins.lsp.keymaps").on_attach(client, buffer)
          end
        end,
      })

      local servers = {
        biome = { enabled = false },
        gopls = {},
        lua_ls = {},
        solargraph = {
          mason = false,
          enabled = vim.fs.find(".solargraph.yml", { path = vim.uv.cwd(), upward = true })[1] ~= nil,
          cmd = { "asdf", "exec", "solargraph", "stdio" },
          diagnostics = true,
        },
        ts_ls = {},
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", {}, capabilities, require("blink.cmp").get_lsp_capabilities())

      local function setup(server)
        require("lspconfig")[server].setup(vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server]))
      end

      local all_mlsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      local ensure_installed = {}

      for server, server_opts in pairs(servers) do
        if server_opts.mason == false or not vim.tbl_contains(all_mlsp_servers, server) then
          setup(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end

      require("mason-lspconfig").setup {
        ensure_installed = ensure_installed,
        automatic_installation = false,
        handlers = { setup },
      }
    end,
  },

  -- mason.nvim
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "biome",
        "gofumpt",
        "goimports",
        "prettierd",
        "stylua",
      },
      ui = { border = "rounded" },
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
