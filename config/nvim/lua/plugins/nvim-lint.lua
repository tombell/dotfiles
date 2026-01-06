return {
  src = "https://github.com/mfussenegger/nvim-lint",
  data = {
    setup = function()
      local linters = {
        eslint = {
          condition = function(ctx)
            return vim.fs.find({
              "eslint.config.js",
              "eslint.config.mjs",
              "eslint.config.cjs",
              "eslint.config.ts",
              "eslint.config.mts",
              "eslint.config.cts",
            }, { path = ctx.filename, upward = true })[1] ~= nil
          end,
        },
      }

      local M = {}

      local lint = require "lint"
      lint.linters_by_ft = {
        javascript = { "eslint" },
        javascriptreact = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
      }

      for name, linter in pairs(linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", {}, lint.linters[name], linter)
        end
      end

      function M.lint()
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)
        names = vim.list_extend({}, names)

        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")

        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          ---@diagnostic disable-next-line: undefined-field
          return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
        end, names)

        if #names > 0 then
          lint.try_lint(names)
        end
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("tombell-lint", { clear = true }),
        callback = require("util").debounce(100, M.lint),
      })
    end,
  },
}
