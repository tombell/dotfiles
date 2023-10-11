return {
  {
    "nvim-neotest/neotest",
    config = function()
      require("neotest").setup {
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
    dependencies = {
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-go",
      "olimorris/neotest-rspec",
    },
  },
}
