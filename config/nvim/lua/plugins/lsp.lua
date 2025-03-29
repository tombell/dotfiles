return {
  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      servers = {
        gopls = {},
        lua_ls = {},
        solargraph = {
          enabled = vim.fs.find(".solargraph.yml", { path = vim.uv.cwd(), upward = true })[1] ~= nil,
        },
        sourcekit = {
          mason = false,
          filetypes = { "swift" },
        },
        tailwindcss = {
          enabled = false,
        },
        ts_ls = {
          enabled = false, -- TODO: enable for older node versions, not supported by vtsls
          init_options = {
            preferences = { importModuleSpecifierPreference = "non-relative" },
          },
        },
        vtsls = {
          enabled = true, -- TODO: disable for older node versions, not supported by vtsls
          settings = {
            typescript = { preferences = { importModuleSpecifier = "non-relative" } },
            javascript = { preferences = { importModuleSpecifier = "non-relative" } },
          },
        },
      },
    },
    config = function(_, opts)
      local servers = opts.servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local function setup(server)
        if servers[server] == nil then
          return
        end

        require("lspconfig")[server].setup(vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server]))
      end

      local ensure_installed = {}

      for server, server_opts in pairs(servers) do
        if server_opts.mason == false then
          setup(server)
        else
          ensure_installed[#ensure_installed + 1] = server
        end
      end

      require("mason-lspconfig").setup {
        automatic_installation = true,
        ensure_installed = ensure_installed,
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
