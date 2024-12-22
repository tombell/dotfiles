return {
  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = {
      "mason.nvim",
      "saghen/blink.cmp",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    opts = {
      diagnostics = {
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
      },
      capabilities = {},
      servers = {
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
      },
      setup = {},
    },
    config = function(_, opts)
      require("lspconfig.ui.windows").default_options.border = "rounded"

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if client then
            return require("tombell.plugins.lsp.keymaps").on_attach(client, buffer)
          end
        end,
      })

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )
      local handlers = vim.tbl_deep_extend("force", {}, opts.handlers or {})

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          handlers = handlers,
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end

        require("lspconfig")[server].setup(server_opts)
      end

      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mlsp_servers = {}

      if have_mason then
        all_mlsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {}

      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts

          if server_opts.mason == false or not vim.tbl_contains(all_mlsp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup { ensure_installed = ensure_installed, handlers = { setup } }
      end
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
