vim.keymap.set({ "n", "o", "x" }, "gc", "<cmd>call VSCodeCall('editor.action.commentLine')<cr><esc>", { remap = true })
vim.keymap.set("n", "gcc", "<cmd>call VSCodeCall('editor.action.commentLine')<cr><esc>", { remap = true })
