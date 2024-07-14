return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
    },
    opts = function()
      local cmp = require "cmp"

      return {
        window = {
          completion = cmp.config.window.bordered { scrollbar = false },
          documentation = cmp.config.window.bordered { scrollbar = false },
        },
        experimental = {
          ghost_text = true,
        },
        mapping = cmp.mapping.preset.insert {
          ["<tab>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<s-tab>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<c-d>"] = cmp.mapping.scroll_docs(-4),
          ["<c-f>"] = cmp.mapping.scroll_docs(4),
          ["<c-space>"] = cmp.mapping.complete(),
          ["<cr>"] = cmp.mapping.confirm { select = false },
        },
        sources = cmp.config.sources({
          { name = "nvim_lua" },
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      }
    end,
  },

  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
