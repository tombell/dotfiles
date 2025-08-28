local ensure_installed = {
  "bash",
  "diff",
  "git_config",
  "git_rebase",
  "ini",
  "json",
  "lua",
  "luadoc",
  "make",
  "python",
  "query",
  "sql",
  "ssh_config",
  "tmux",
  "toml",
  "udev",
  "vimdoc",
  "yaml",
}

vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    ---@diagnostic disable: missing-fields
    require("nvim-treesitter.parsers").skbdrc = {
      install_info = {
        url = "https://github.com/starkwm/tree-sitter-skbdrc",
        queries = "queries/skbdrc",
      },
    }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(ev)
    local ok = pcall(function()
      vim.treesitter.get_parser(ev.buf, vim.treesitter.language.get_lang(vim.bo.filetype))
    end)

    if ok then
      vim.treesitter.start()
    end
  end,
})

return {
  -- nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    config = function()
      require("nvim-treesitter").setup {
        install_dir = vim.fn.stdpath "data" .. "/site",
      }
      require("nvim-treesitter").install(ensure_installed)
    end,
  },
}
