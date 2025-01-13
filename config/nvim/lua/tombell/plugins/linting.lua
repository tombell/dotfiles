return {
  -- nvim-lint
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        javascript = { "biomejs", "eslint" },
        javascriptreact = { "biomejs", "eslint" },
        ruby = { "rubocop" },
        typescript = { "biomejs", "eslint" },
        typescriptreact = { "biomejs", "eslint" },
      },
      linters = {
        biomejs = {
          condition = function(ctx)
            return vim.fs.find({ "biome.json" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        eslint = {
          condition = function(ctx)
            return vim.fs.find({ "eslint.config.js" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        rubocop = {
          condition = function(ctx)
            return not vim.fs.find({ ".solargraph.yml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    },
    config = function(_, opts)
      local M = {}

      local lint = require "lint"
      lint.linters_by_ft = opts.linters_by_ft

      for name, linter in pairs(opts.linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", {}, lint.linters[name], linter)
        end
      end

      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()

        return function(...)
          if timer ~= nil then
            local argv = { ... }
            timer:start(ms, 0, function()
              timer:stop()
              vim.schedule_wrap(fn)(unpack(argv))
            end)
          end
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

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = M.debounce(100, M.lint),
      })
    end,
  },
}
