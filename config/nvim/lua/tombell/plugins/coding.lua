return {
  {
    "lifepillar/pgsql.vim",
    ft = "sql",
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    opts = function()
      local cmp = require "cmp"

      return {
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<tab>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<s-tab>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<c-d>"] = cmp.mapping.scroll_docs(-4),
          ["<c-f>"] = cmp.mapping.scroll_docs(4),
          ["<c-space>"] = cmp.mapping.complete(),
          ["<cr>"] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      }
    end,
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },

  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-go",
      "olimorris/neotest-rspec",
    },
    opts = function()
      return {
        adapters = {
          require "neotest-go",
          require "neotest-jest",
          require "neotest-rspec",
          require "neotest-vitest",
        },
      }
    end,
    keys = {
      { "<leader>t", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>" },
      { "<leader>o", "<cmd>lua require('neotest').output_panel.toggle()<cr>" },
      { "<leader>s", "<cmd>lua require('neotest').summary.toggle()<cr>" },
    },
  },
}
