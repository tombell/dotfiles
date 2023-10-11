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
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--glob", "!.git/*" },
            hidden = true,
            previewer = false,
          },
        },
      }
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
}
