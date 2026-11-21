-- Finding the focused terminal's directory and choosing which git repo an action acts on.

local util = require("custom_ui.util")

local M = {}

----------------------------------------------------------------------------------------------
-- Focused terminal's working directory
--
-- Docs: the terminal block has a `pwd` method ("Return the working directory the terminal last
-- reported") and a `process` method ("Describe the terminal's child and foreground processes"),
-- both callable as rex.block.call("com.superlogical.terminal", "pwd"), with block_id filled in
-- from the current block. The `terminal.pwd_changed` event's `pwd` is a file:// URL such as
-- file://hostname/Users/you/src, and "is only reported by shells set up to report it".
-- The terminal.process_changed event's `foreground` has `name`, `cwd`, `pid`, "and more".
-- UNVERIFIED: the exact result shape of the `pwd` and `process` methods isn't in the docs, so the
-- code below accepts a plain string/URL or a table under any of several likely keys. Run
-- `rex do cwd_debug` in a terminal to see the raw values on your install.
----------------------------------------------------------------------------------------------
local function url_to_path(s)
  if type(s) ~= "string" or s == "" then return nil end
  local p = s:match("^file://[^/]*(/.*)$")      -- file://host/path and file:///path
  if p then
    return (p:gsub("%%(%x%x)", function(h) return string.char(tonumber(h, 16)) end))
  end
  if s:sub(1, 1) == "/" then return s end
  return nil
end

local PATH_KEYS = { "pwd", "path", "cwd", "dir", "directory", "url", "uri" }

local function extract_path(v, depth)
  depth = depth or 0
  if type(v) == "string" then return url_to_path(v) end
  if type(v) ~= "table" or depth > 3 then return nil end
  for _, k in ipairs(PATH_KEYS) do
    local p = extract_path(v[k], depth + 1)
    if p then return p end
  end
  return nil
end

-- Find a `cwd` anywhere in a `process` result, trying `foreground` first.
local function extract_process_cwd(v, depth)
  depth = depth or 0
  if type(v) ~= "table" or depth > 4 then return nil end
  if type(v.foreground) == "table" then
    local p = extract_path(v.foreground.cwd)
    if p then return p end
  end
  local p = extract_path(v.cwd)
  if p then return p end
  for _, child in pairs(v) do
    if type(child) == "table" then
      local found = extract_process_cwd(child, depth + 1)
      if found then return found end
    end
  end
  return nil
end

-- Returns path, source ("pwd" | "process") — or nil, reason.
function M.focused_cwd()
  local r, err = rex.block.call(util.TERMINAL, "pwd", {})
  local p = extract_path(r)
  if p then return p, "pwd" end
  local r2, err2 = rex.block.call(util.TERMINAL, "process", {})
  p = extract_process_cwd(r2)
  if p then return p, "process" end
  return nil, tostring(err or err2 or "terminal reported no working directory (shell integration off?)")
end

function M.git_toplevel(dir)
  local out = util.exec_out({ "git", "rev-parse", "--show-toplevel" }, { cwd = dir, timeout = 5 })
  out = out and util.trim(out)
  if out and out ~= "" then return out end
  return nil
end

-- All git repos under code_root, `max_depth` levels deep, sorted. A repo is a directory holding
-- a `.git` (directory, or file for worktrees/submodules).
function M.list_repos()
  local root = util.code_root()
  local out, err = util.exec_out({
    "find", root, "-maxdepth", tostring(util.config.max_depth + 1),
    "(", "-name", "node_modules", "-prune", ")", "-o",
    "(", "-name", ".git", "-prune", "-print", ")",
  }, { timeout = 15 })
  if out == nil then return nil, err end
  local repos = {}
  for line in out:gmatch("[^\r\n]+") do
    local dir = line:gsub("/%.git$", "")
    if dir ~= root then
      repos[#repos + 1] = { path = dir, name = util.basename(dir), rel = dir:sub(#root + 2) }
    end
  end
  table.sort(repos, function(a, b) return a.rel:lower() < b.rel:lower() end)
  return repos
end

-- Prompts for a repo from list_repos. Must be called directly from an action's run (it uses
-- rex.ui.pick, which doesn't work under pcall). Returns the path, or nil, reason.
function M.pick_repo(title)
  local repos, err = M.list_repos()
  if repos == nil then return nil, err end
  if #repos == 0 then return nil, "no git repos under " .. util.code_root() end
  local items = {}
  for _, r in ipairs(repos) do
    items[#items + 1] = { id = r.path, title = r.name, subtitle = r.rel, icon = "folder" }
  end
  local dir, why = rex.ui.pick{ title = title, placeholder = "Filter repositories", items = items }
  if dir == nil then return nil, why end
  return dir
end

-- Work out which repo an action should act on:
--   1. args.dir (so `rex do stage_commit dir=/path` works headless),
--   2. the focused terminal's working directory -> its git toplevel,
--   3. fallback: ask which repo (pick_repo), because the directory couldn't be determined.
-- Returns repo path, or nil + reason ("cancelled" reasons from the picker are passed through).
function M.resolve_repo(args, what)
  if args and args.dir then
    local top = M.git_toplevel(args.dir)
    if top then return top, "arg" end
    return nil, "not a git repository: " .. args.dir
  end
  local cwd, source = M.focused_cwd()
  if cwd then
    local top = M.git_toplevel(cwd)
    if top then return top, source end
    -- Terminal is somewhere that isn't a repo: let Tom choose instead of failing.
  end
  local dir, why = M.pick_repo(what .. ": pick a repository (terminal isn't in a git repo or its directory is unknown)")
  if not dir then return nil, why end
  return M.git_toplevel(dir) or dir, "picker"
end

return M
