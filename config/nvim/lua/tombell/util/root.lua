local Util = require "lazy.core.util"

local M = setmetatable({}, {
  __call = function(m)
    return m.get()
  end,
})

M.spec = { "lsp", { ".git", "lua" }, "cwd" }

M.detectors = {}

function M.detectors.cwd()
  return { vim.loop.cwd() }
end

function M.detectors.lsp(buf)
  local bufpath = M.bufpath(buf)

  if not bufpath then
    return {}
  end

  local roots = {}

  for _, client in pairs(tombell.lsp.get_clients { bufnr = buf }) do
    local workspace = client.config.workspace_folders

    for _, ws in pairs(workspace or {}) do
      roots[#roots + 1] = vim.uri_to_fname(ws.uri)
    end
  end

  return vim.tbl_filter(function(path)
    path = Util.norm(path)
    return path and bufpath:find(path, 1, true) == 1
  end, roots)
end

function M.detectors.pattern(buf, patterns)
  patterns = type(patterns) == "string" and { patterns } or patterns

  local path = M.bufpath(buf) or vim.loop.cwd()
  local pattern = vim.fs.find(patterns, { path = path, upward = true })[1]

  return pattern and { vim.fs.dirname(pattern) } or {}
end

function M.bufpath(buf)
  return M.realpath(vim.api.nvim_buf_get_name(assert(buf)))
end

function M.cwd()
  return M.realpath(vim.loop.cwd()) or ""
end

function M.realpath(path)
  if path == "" or path == nil then
    return nil
  end

  path = vim.loop.fs_realpath(path) or path
  return Util.norm(path)
end

function M.resolve(spec)
  if M.detectors[spec] then
    return M.detectors[spec]
  end

  return function(buf)
    return M.detectors.pattern(buf, spec)
  end
end

function M.detect(opts)
  opts = opts or {}
  opts.spec = opts.spec or type(vim.g.root_spec) == "table" and vim.g.root_spec or M.spec
  opts.buf = (opts.buf == nil or opts.buf == 0) and vim.api.nvim_get_current_buf() or opts.buf

  local ret = {}

  for _, spec in ipairs(opts.spec) do
    local paths = M.resolve(spec)(opts.buf)
    paths = paths or {}
    paths = type(paths) == "table" and paths or { paths }

    local roots = {}

    for _, p in ipairs(paths) do
      local pp = M.realpath(p)

      if pp and not vim.tbl_contains(roots, pp) then
        roots[#roots + 1] = pp
      end
    end

    table.sort(roots, function(a, b)
      return #a > #b
    end)

    if #roots > 0 then
      ret[#ret + 1] = { spec = spec, paths = roots }

      if opts.all == false then
        break
      end
    end
  end

  return ret
end

M.cache = {}

function M.get()
  local buf = vim.api.nvim_get_current_buf()
  local ret = M.cache[buf]

  if not ret then
    local roots = M.detect { all = false }
    ret = roots[1] and roots[1].paths[1] or vim.loop.cwd()
    M.cache[buf] = ret
  end

  return ret
end

return M
