return {
  src = "https://github.com/lewis6991/gitsigns.nvim",
  data = {
    setup = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        signs_staged = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
        },
        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          vim.keymap.set("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal { "]c", bang = true }
            else
              gs.nav_hunk "next"
            end
          end, { desc = "Next Hunk", buffer = buffer })

          vim.keymap.set("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal { "[c", bang = true }
            else
              gs.nav_hunk "prev"
            end
          end, { desc = "Prev Hunk", buffer = buffer })

          -- stylua: ignore start
          vim.keymap.set("n", "]H", function() gs.nav_hunk("last") end, { desc = "Last Hunk" })
          vim.keymap.set("n", "[H", function() gs.nav_hunk("first") end, { desc = "First Hunk" })
          vim.keymap.set({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk", buffer = buffer })
          vim.keymap.set({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk", buffer = buffer })
          vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer", buffer = buffer })
          vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk", buffer = buffer })
          vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer", buffer = buffer })
          vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Hunk", buffer = buffer })
          vim.keymap.set("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { desc = "Blame (Line)", buffer = buffer })
          vim.keymap.set("n", "<leader>ghB", function() gs.blame() end, { desc = "Blame (Buffer)", buffer = buffer })
          vim.keymap.set("n", "<leader>ghd", gs.diffthis, { desc = "Diff This", buffer = buffer })
          vim.keymap.set("n", "<leader>ghD", function() gs.diffthis("~") end, { desc = "Diff This ~", buffer = buffer })
          vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk", buffer = buffer })
          -- stylua: ignore end
        end,
      }
    end,
  },
}
