return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<c-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>" },
      { "<c-g>", "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
      { "<leader>f", "<cmd>lua require('telescope.builtin').grep_string()<cr>" },
    },
    opts = function()
      local actions = require "telescope.actions"

      return {
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())

            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)

              if vim.bo[buf].buftype == "" then
                return win
              end
            end

            return 0
          end,
          mappings = {
            i = {
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            follow = true,
          },
        },
      }
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = {
        separator = "",
      },
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>t"] = { name = "+test" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
}
