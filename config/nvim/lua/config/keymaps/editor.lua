-- Remove neovim (0.11) default mappings
vim.keymap.del("n", "grn")
vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gO")
vim.keymap.del({ "i", "s" }, "<C-s>")

vim.keymap.set("n", "<leader>l", "<cmd>lua vim.pack.update()<cr>", { desc = "Update plugins" })

vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Go to right window", remap = true })

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- stylua: ignore start
vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", require("util").picker("grep"), { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader><space>", require("util").picker("files"), { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
-- stylua: ignore end

-- stylua: ignore start
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath "config" --[[@as string]] }) end, { desc = "Find Config Files" })
vim.keymap.set("n", "<leader>ff", require("util").picker("files"), { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>fF", function() Snacks.picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Files (Git)" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
vim.keymap.set("n", "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true } }) end, { desc = "Recent (Current Dir)" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
-- stylua: ignore end

-- stylua: ignore start
vim.keymap.set("n", "<leader>gc", function() Snacks.picker.git_log() end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
vim.keymap.set("n", "<leader>gD", function() Snacks.picker.git_diff({ base = "origin", group = true }) end, { desc = "Git Diff (Origin)" })
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
vim.keymap.set("n", "<leader>gi", function() Snacks.picker.gh_issue() end, { desc = "GitHub Issues (Open)" })
vim.keymap.set("n", "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, { desc = "GitHub Issues" })
vim.keymap.set("n", "<leader>gp", function() Snacks.picker.gh_pr() end, { desc = "GitHub Pull Requests (Open)" })
vim.keymap.set("n", "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, { desc = "GitHub Pull Requests" })
-- stylua: ignore end

-- stylua: ignore start
vim.keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep (Buffers)" })
vim.keymap.set("n", "<leader>sg", require("util").picker("grep"), { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>sG", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set({ "n", "x" }, "<leader>sw", require("util").picker("grep_word"), { desc = "Visual selection or word (Root Dir)" })
vim.keymap.set({ "n", "x" }, "<leader>sW", function() Snacks.picker.grep_word() end, { desc = "Visual selection or word" })
-- stylua: ignore end

-- stylua: ignore start
vim.keymap.set("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
vim.keymap.set("n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "Search History" })
vim.keymap.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
vim.keymap.set("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
vim.keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
vim.keymap.set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
vim.keymap.set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
vim.keymap.set("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
vim.keymap.set("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undotree" })
-- stylua: ignore end

-- stylua: ignore start
vim.keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
-- stylua: ignore end

Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
Snacks.toggle.diagnostics():map "<leader>ud"
Snacks.toggle.line_number():map "<leader>ul"
Snacks.toggle.inlay_hints():map "<leader>uh"

-- stylua: ignore start
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next Todo Comment" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous Todo Comment" })
-- stylua: ignore end
