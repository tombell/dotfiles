return {
  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    event = "VeryLazy",
    config = function()
      vim.diagnostic.config {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
          },
        },
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("tombell-lsp-attach", { clear = true }),
        callback = function(event)
          local function map(lhs, rhs, desc, mode, opts)
            mode = mode or "n"
            opts = opts or { buffer = event.buf, desc = desc }
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          -- stylua: ignore start
          map("<leader>cl", "<cmd>LspInfo<cr>", "LSP Info")
          map("gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
          map("gr", function() Snacks.picker.lsp_references() end, "References")
          map("gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
          map("gy", function() Snacks.picker.lsp_type_definitions() end,"Goto Type Definition")
          map("<leader>ss", function() Snacks.picker.lsp_symbols() end,"LSP Symbols")
          map("gD", vim.lsp.buf.declaration, "Goto Declaration")
          map("K", vim.lsp.buf.hover, "Hover")
          map("gK", vim.lsp.buf.signature_help, "Signature Help")
          map("<c-k>", vim.lsp.buf.signature_help, "Signature Help", "i")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "v" })
          map("<leader>cc", vim.lsp.codelens.run, "Run Codelens", { "n", "v" })
          map("<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens", "n")
          map("<leader>cR", function() Snacks.rename.rename_file() end, "Rename File", "n")
          map("<leader>cr", vim.lsp.buf.rename, "Rename")
          map("]]", function() Snacks.words.jump(vim.v.count1) end, "Next Reference")
          map("[[", function() Snacks.words.jump(-vim.v.count1) end, "Prev Reference")
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
        },
        ts_ls = {
          init_options = {
            preferences = {
              importModuleSpecifierPreference = "non-relative",
            },
          },
        },
        zls = {},
      }

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

      vim.list_extend(ensure_installed, {
        "biome",
        "gofumpt",
        "goimports",
        "prettier",
        "stylua",
      })

      require("mason").setup()
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }
      ---@diagnostic disable: missing-fields
      require("mason-lspconfig").setup { handlers = { setup } }
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
