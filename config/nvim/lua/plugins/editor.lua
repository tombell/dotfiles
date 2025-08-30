local util = require "util"

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

  -- nvim-highlight-colors
  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
      virtual_symbol_prefix = " ",
      virtual_symbol_suffix = "",
      virtual_symbol_position = "eol",
      enable_hsl_without_function = false,
    },
  },

  -- snacks.nvim
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        layout = "vertical",
        sources = {
          files = {
            hidden = true,
            follow = true,
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep({ cwd = util.root() }) end, desc = "Grep (Root Dir)" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader><space>", function() Snacks.picker.files({ cwd = util.root() }) end, desc = "Find Files (Root Dir)" },

      -- Explorer
      { "<leader>fe", function() Snacks.explorer({ cwd = util.root() }) end, desc = "Explorer (Root Dir)" },
      { "<leader>fE", function() Snacks.explorer() end, desc = "Explorer" },

      -- Find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath "config" --[[@as string]] }) end, desc = "Find Config File" },
      { "<leader>ff", function() Snacks.picker.files({ cwd = util.root() }) end, desc = "Find Files (Root Dir)" },
      { "<leader>fF", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Files (Git)" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true } }) end, desc = "Recent (Current Dir)" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },

      -- Git
      { "<leader>gc", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },

      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep (Buffers)" },
      { "<leader>sg", function() Snacks.picker.grep({ cwd = util.root() }) end, desc = "Grep (Root Dir)" },
      { "<leader>sG", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word({ cwd = util.root() }) end, desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
      { "<leader>sW", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

      -- Search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undotree" },

      -- UI
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    },
  },

  -- todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    cmd = { "TodoTrouble" },
    opts = {
      signs = false,
    },
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
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
      delay = 500,
      preset = "helix",
      spec = {
        {
          mode = { "n", "v" },
          -- { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          -- { "<leader>d", group = "debug" },
          -- { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>t", group = "test" },
          { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
          { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          -- { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
        },
      },
    },
  },
}
