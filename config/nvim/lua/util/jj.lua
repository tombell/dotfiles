local M = {}

local cache = {}

function M.root()
  if vim.fn.executable "jj" == 0 then
    return nil
  end

  local name = vim.api.nvim_buf_get_name(0)
  local path = name ~= "" and vim.fs.dirname(name) or vim.fn.getcwd()
  local root = vim.fs.root(path, { ".jj", ".git" })

  return root and vim.uv.fs_stat(root .. "/.jj") and root or nil
end

function M.status()
  local root = M.root()
  if not root then
    return ""
  end

  local entry = cache[root] or { text = "", updated = 0 }
  cache[root] = entry

  if not entry.pending and vim.uv.hrtime() / 1e6 - entry.updated >= 2000 then
    entry.pending = true
    local results = {}
    local function query(key, revisions, template)
      vim.system({
        "jj",
        "--ignore-working-copy",
        "--color=never",
        "log",
        "--no-graph",
        "--revisions=" .. revisions,
        "--template",
        template,
      }, { cwd = root, text = true, timeout = 5000 }, function(result)
        vim.schedule(function()
          results[key] = result.code == 0 and vim.trim(result.stdout) or ""
          if results.bookmark == nil or results.change == nil then
            return
          end

          entry.pending = false
          entry.updated = vim.uv.hrtime() / 1e6
          local prefix = results.bookmark ~= "" and results.bookmark .. ":: " or ""
          local text = results.change ~= "" and prefix .. "@" .. results.change or ""
          entry.text = text:gsub("%%", "%%%%")
          require("lualine").refresh { place = { "statusline" } }
        end)
      end)
    end

    query("bookmark", "latest(ancestors(@) & bookmarks())", 'bookmarks.map(|b| b.name()).join(",")')
    query("change", "@", "change_id.shortest(4)")
  end

  return entry.text
end

return M
