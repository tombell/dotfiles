local util = require "util"

-- Remove neovim (0.11) default mappings
vim.keymap.del("n", "grn")
vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gO")
vim.keymap.del({ "i", "s" }, "<C-s>")

vim.keymap.set("n", "<leader>l", "<cmd>lua vim.pack.update()<cr>", { desc = "Update plugins" })

vim.keymap.set("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" })

vim.keymap.set("n", "<c-h>", "<c-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<c-j>", "<c-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<c-k>", "<c-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<c-l>", "<c-w>l", { desc = "Go to right window", remap = true })

vim.keymap.set("n", "<c-up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<c-down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<c-left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<c-right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"

Snacks.toggle.line_number():map "<leader>ul"
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"

Snacks.toggle.diagnostics():map "<leader>ud"
Snacks.toggle.inlay_hints():map "<leader>uh"

vim.keymap.set("n", "<leader>uv", function()
  vim.diagnostic.config { virtual_lines = not vim.diagnostic.config().virtual_lines }
end, { desc = "Toggle diagnostic virtual lines" })

-- stylua: ignore start
vim.keymap.set("n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", util.picker("grep"), { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" })
vim.keymap.set("n", "<leader><space>", util.picker("files"), { desc = "Find Files (Root Dir)" })
-- stylua: ignore end

-- stylua: ignore start
vim.keymap.set("n", "<leader>fe", function() Snacks.explorer({ cwd = util.root() }) end, { desc = "Explorer (Root Dir)" })
vim.keymap.set("n", "<leader>fE", function() Snacks.explorer() end, { desc = "Explorer" })
-- stylua: ignore end

-- stylua: ignore start
vim.keymap.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath "config" --[[@as string]] }) end, { desc = "Find Config File" })
vim.keymap.set("n", "<leader>ff", util.picker("files"), { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>fF", function() Snacks.picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Files (Git)" })
vim.keymap.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })
vim.keymap.set("n", "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true } }) end, { desc = "Recent (Current Dir)" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
-- stylua: ignore end

-- stylua: ignore start
vim.keymap.set("n", "<leader>gc", function() Snacks.picker.git_log() end, { desc = "Git Log" })
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
-- stylua: ignore end

-- stylua: ignore start
vim.keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
vim.keymap.set("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep (Buffers)" })
vim.keymap.set("n", "<leader>sg", util.picker("grep"), { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>sG", function() Snacks.picker.grep() end, { desc = "Grep" })
vim.keymap.set({ "n", "x" }, "<leader>sw", util.picker("grep_word"), { desc = "Visual selection or word (Root Dir)" })
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

-- stylua: ignore start
vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Execute opencode action" })
vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end, { expr = true, desc = "Add range to opencode" })
vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { expr = true, desc = "Add line to opencode" })
-- stylua: ignore end
