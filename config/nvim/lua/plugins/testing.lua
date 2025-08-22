return {
  -- neotest
  {
    "nvim-neotest/neotest",
    branch = "fix/subprocess/load-adapters",
    lazy = true,
    dependencies = {
      -- main
      "nvim-lua/plenary.nvim",
      { "nvim-neotest/nvim-nio", lazy = true },
      -- adapters
      -- "Arthur944/neotest-bun",
      "fredrikaverpil/neotest-golang",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "olimorris/neotest-rspec",
    },
    config = function()
      ---@diagnostic disable: missing-fields
      require("neotest").setup {
        adapters = {
          -- require "neotest-bun",
          require "neotest-golang",
          require "neotest-jest",
          require "neotest-rspec",
          require "neotest-vitest",
        },
      }
    end,
    -- stylua: ignore
    keys = {
      { "<leader>t", group = "test" },
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
    },
  },
}
