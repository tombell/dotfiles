-- Finding the focused terminal's directory and choosing which git repo an action acts on.

local util = require "custom_ui.util"

local M = {}

-- The terminal's `pwd` method returns { pwd = "file://host/path" } (or a plain path) when the
-- shell reports its directory; `process` returns { foreground = { cwd = "/path" } }.
local function url_to_path(s)
  if type(s) ~= "string" then
    return nil
  end
  local p = s:match "^file://[^/]*(/.*)$"
  if p then
    return (p:gsub("%%(%x%x)", function(h)
      return string.char(tonumber(h, 16))
    end))
  end
  if s:sub(1, 1) == "/" then
    return s
  end
end

-- The focused terminal's working directory, or nil.
function M.focused_cwd()
  local r = rex.block.call(util.TERMINAL, "pwd", {})
  local p = url_to_path(r and r.pwd)
  if p then
    return p
  end
  local proc = rex.block.call(util.TERMINAL, "process", {})
  return proc and proc.foreground and proc.foreground.cwd
end

function M.git_toplevel(dir)
  local out = util.exec_out({ "git", "rev-parse", "--show-toplevel" }, { cwd = dir, timeout = 5 })
  out = out and util.trim(out)
  if out and out ~= "" then
    return out
  end
  return nil
end

-- All git repos under code_root, `max_depth` levels deep, sorted. A repo is a directory holding
-- a `.git` (directory, or file for worktrees/submodules).
function M.list_repos()
  local root = util.code_root()
  local out, err = util.exec_out({
    "find",
    root,
    "-maxdepth",
    tostring(util.config.max_depth + 1),
    "(",
    "-name",
    "node_modules",
    "-prune",
    ")",
    "-o",
    "(",
    "-name",
    ".git",
    "-prune",
    "-print",
    ")",
  }, { timeout = 15 })
  if out == nil then
    return nil, err
  end
  local repos = {}
  for line in out:gmatch "[^\r\n]+" do
    local dir = line:gsub("/%.git$", "")
    if dir ~= root then
      repos[#repos + 1] = { path = dir, name = util.basename(dir), rel = dir:sub(#root + 2) }
    end
  end
  table.sort(repos, function(a, b)
    return a.rel:lower() < b.rel:lower()
  end)
  return repos
end

-- Prompts for a repo from list_repos. Must be called directly from an action's run (it uses
-- rex.ui.pick, which doesn't work under pcall). Returns the path, or nil, reason.
function M.pick_repo(title)
  local repos, err = M.list_repos()
  if repos == nil then
    return nil, err
  end
  if #repos == 0 then
    return nil, "no git repos under " .. util.code_root()
  end
  local items = {}
  for _, r in ipairs(repos) do
    items[#items + 1] = { id = r.path, title = r.name, subtitle = r.rel, icon = "folder" }
  end
  return rex.ui.pick { title = title, placeholder = "Filter repositories", items = items }
end

-- Work out which repo an action should act on:
--   1. args.dir (so `rex do worktree_jump dir=/path` works headless),
--   2. the focused terminal's working directory -> its git toplevel,
--   3. fallback: ask which repo (pick_repo), because the directory couldn't be determined.
-- Returns repo path, or nil + reason ("cancelled" reasons from the picker are passed through).
function M.resolve_repo(args, what)
  if args.dir then
    local top = M.git_toplevel(args.dir)
    if top then
      return top
    end
    return nil, "not a git repository: " .. args.dir
  end
  local cwd = M.focused_cwd()
  local top = cwd and M.git_toplevel(cwd)
  if top then
    return top
  end
  local dir, why = M.pick_repo(what .. ": pick a repository (terminal isn't in a git repo or its directory is unknown)")
  if not dir then
    return nil, why
  end
  return M.git_toplevel(dir) or dir
end

return M
