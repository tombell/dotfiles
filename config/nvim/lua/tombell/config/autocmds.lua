local function augroup(name)
  return vim.api.nvim_create_augroup("tombell_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup "formatoptions",
  callback = function()
    vim.opt_local.formatoptions:remove { "o" }
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup "trim_whitespace",
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup "close_with_q",
  pattern = {
    "checkhealth",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "qf",
    "query",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup "dotenv",
  pattern = { ".env", ".env.*" },
  callback = function()
    vim.opt_local.filetype = "sh"
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup "gotmpl",
  pattern = { "*.gotmpl", "*.gohtml", "*.tmpl.html", "*.tmpl.txt" },
  callback = function()
    vim.opt_local.filetype = "gotmpl"
  end,
})
