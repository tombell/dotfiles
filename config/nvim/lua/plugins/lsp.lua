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
        ruby_lsp = { enabled = false },
        solargraph = {
          enabled = vim.fs.find(".solargraph.yml", { path = vim.uv.cwd(), upward = true })[1] ~= nil,
        },
        tailwindcss = {},
        ts_ls = {
          init_options = {
            preferences = { importModuleSpecifierPreference = "non-relative" },
          },
        },
        vtsls = { enabled = false },
        zls = {},
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("tombell-lsp-attach", { clear = true }),
        callback = function(event)
          local function map(lhs, rhs, desc, mode, o)
            mode = mode or "n"
            o = o or { buffer = event.buf, desc = desc }
            vim.keymap.set(mode, lhs, rhs, o)
          end

          -- stylua: ignore start
          map("<leader>cl", "<cmd>LspInfo<cr>", "LSP Info")
          map("gd", function() Snacks.picker.lsp_definitions() end, "Goto Definition")
          map("gr", function() Snacks.picker.lsp_references() end, "References")
          map("gI", function() Snacks.picker.lsp_implementations() end, "Goto Implementation")
          map("gy", function() Snacks.picker.lsp_type_definitions() end, "Goto Type Definition")
          map("<leader>ss", function() Snacks.picker.lsp_symbols() end, "LSP Symbols")
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
