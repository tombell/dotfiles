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
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
          end

          -- stylua: ignore start
          map("<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
          map("gd", function() require("telescope.builtin").lsp_definitions { reuse_win = true } end, "Goto Definition")
          map("gr", function() require("telescope.builtin").lsp_references { reuse_win = true } end, "References")
          map("gI", function() require("telescope.builtin").lsp_implementations { reuse_win = true } end, "Goto Implementation")
          map("gy", function() require("telescope.builtin").lsp_type_definitions { reuse_win = true } end,"Goto T[y]pe Definition")
          map("gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("K", vim.lsp.buf.hover, "Hover")
          map("gK", vim.lsp.buf.signature_help, "Signature Help")
          map("<c-k>", vim.lsp.buf.signature_help, "Signature Help", "i")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
          map("<leader>cc", vim.lsp.codelens.run, "Run Codelens", { "n", "v" })
          map("<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens", "n")
          map("<leader>cr", vim.lsp.buf.rename, "Rename")
          -- stylua: ignore end
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
