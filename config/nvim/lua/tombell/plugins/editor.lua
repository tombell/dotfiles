return {
  -- gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
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

        -- stylua: ignore start
        vim.keymap.set("n", "]h", gs.next_hunk, { desc = "Next Hunk", buffer = buffer })
        vim.keymap.set("n", "[h", gs.prev_hunk, { desc = "Prev Hunk", buffer = buffer })
        vim.keymap.set( { "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk", buffer = buffer })
        vim.keymap.set( { "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk", buffer = buffer })
        vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer", buffer = buffer })
        vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk", buffer = buffer })
        vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer", buffer = buffer })
        vim.keymap.set("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Hunk", buffer = buffer })
        vim.keymap.set("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line", buffer = buffer })
        vim.keymap.set("n", "<leader>ghd", gs.diffthis, { desc = "Diff This", buffer = buffer })
        vim.keymap.set("n", "<leader>ghD", function() gs.diffthis("~") end, { desc = "Diff This ~", buffer = buffer })
        vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk", buffer = buffer })
        -- stylua: ignore end
      end,
    },
  },

  -- snacks.nvim
  {
    "folke/snacks.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", tombell.pick("grep"), desc = "Grep (Root Dir)" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader><space>", tombell.pick("files"), desc = "Find Files (Root Dir)" },

      -- Find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", tombell.pick("files", { cwd = vim.fn.stdpath "config", follow = true }), desc = "Find Config File" },
      { "<leader>ff", tombell.pick "files", desc = "Find Files (Root Dir)" },
      { "<leader>fF", tombell.pick("files", { root = false }), desc = "Find Files (cwd)" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (Git)" },
      { "<leader>fr", tombell.pick("oldfiles"), desc = "Recent" },
      { "<leader>fR", tombell.pick("oldfiles", { filter = { cwd = true }}), desc = "Recent (cwd)" },

      -- Git
      { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gc", function() Snacks.picker.git_status() end, desc = "Git Status" },

      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", tombell.pick("grep"), desc = "Grep (Root Dir)" },
      { "<leader>sG", tombell.pick("grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>sw", tombell.pick("grep_word"), desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
      { "<leader>sW", tombell.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" } },

      -- Search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>qp", function() Snacks.picker.projects() end, desc = "Projects" },

      -- UI
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    },
    opts = {
      picker = {
        layout = "vertical",
      },
    },
  },

  -- todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    cmd = { "TodoTrouble", "TodoTelescope" },
    opts = {
      signs = false,
    },
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },

      ---@diagnostic disable-next-line: undefined-field
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
      ---@diagnostic disable-next-line: undefined-field
      { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },

  -- trouble.nvim
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },

  -- which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 800,
      preset = "helix",
      icons = {
        separator = "",
      },
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>b", group = "buffer" },
          { "<leader>c", group = "code" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>t", group = "test" },
          { "<leader>u", group = "ui" },
          { "<leader>w", group = "windows" },
          { "<leader>x", group = "diagnostics/quickfix" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "z", group = "fold" },
        },
      },
    },
  },
}
