return {
  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    event = "VeryLazy",
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
          local map = function(lhs, rhs, desc, mode, opts)
            mode = mode or "n"
            opts = opts or { buffer = event.buf, desc = desc }
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          -- stylua: ignore start
          map("<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")
          map("gd", function() require("telescope.builtin").lsp_definitions { reuse_win = true } end, "Goto Definition")
          map("gr", function() require("telescope.builtin").lsp_references { reuse_win = true } end, "References")
          map("gI", function() require("telescope.builtin").lsp_implementations { reuse_win = true } end, "Goto Implementation")
          map("gy", function() require("telescope.builtin").lsp_type_definitions { reuse_win = true } end,"Goto Type Definition")
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

      vim.list_extend(ensure_installed, {
        "biome",
        "gofumpt",
        "goimports",
        "prettierd",
        "stylua",
      })

      require("mason").setup()

      require("mason-tool-installer").setup {
        ensure_installed = ensure_installed,
      }

      require("mason-lspconfig").setup {
        automatic_installation = false,
        ensure_installed = {},
        handlers = { setup },
      }
    end,
  },

  -- mason.nvim
  {
    "williamboman/mason.nvim",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },
}
