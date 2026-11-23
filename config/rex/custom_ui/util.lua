-- Shared configuration and helpers for the custom_ui actions.

local M = {}

----------------------------------------------------------------------------------------------
-- Configuration (edit here, or from init.lua: require("custom_ui").config.code_root = "...")
----------------------------------------------------------------------------------------------
M.config = {
  home = os.getenv "HOME" or "/Users/tombell",
  code_root = nil, -- default: <home>/Code
  max_depth = 2, -- how many directory levels below code_root to look for repos
  --   2 => ~/Code/*/  and  ~/Code/starkwm/*/
  pr_limit = 50, -- max PRs listed by pr_checkout
  -- Rex's server may not have Homebrew on its PATH, so it is prepended for git/gh lookups.
  extra_path = "/opt/homebrew/bin:/usr/local/bin",
}
local CONFIG = M.config

M.TERMINAL = "com.superlogical.terminal"
M.SHELL = "com.superlogical.terminal.shell"

function M.code_root()
  return (tostring(CONFIG.code_root or (CONFIG.home .. "/Code")):gsub("/+$", ""))
end

function M.trim(s)
  return (tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

function M.shorten(path)
  local home = CONFIG.home
  if path:sub(1, #home + 1) == home .. "/" then
    return "~" .. path:sub(#home + 1)
  end
  return path
end

function M.basename(path)
  return path:match "([^/]+)/*$" or path
end

-- Run a command with rex.exec. Returns the result table (or nil, err if it never ran).
-- No shell is involved, so argv needs no quoting. git/gh never prompt; output has no colour.
function M.exec(argv, opts)
  opts = opts or {}
  local path = CONFIG.extra_path .. ":" .. (os.getenv "PATH" or "/usr/bin:/bin:/usr/sbin:/sbin")
  return rex.exec(argv, {
    cwd = opts.cwd,
    stdin = opts.stdin,
    timeout = opts.timeout or 20, -- actions get 30 s in total (prompt time excluded)
    env = { PATH = path, GIT_TERMINAL_PROMPT = "0", GH_PROMPT_DISABLED = "1", NO_COLOR = "1" },
  })
end

-- Like exec but returns stdout on success, or nil + a readable error message.
function M.exec_out(argv, opts)
  local r, err = M.exec(argv, opts)
  if r == nil then
    return nil, argv[1] .. ": " .. tostring(err)
  end
  if not r.ok then
    local msg = M.trim(r.stderr)
    if msg == "" then
      msg = M.trim(r.stdout)
    end
    if r.timed_out then
      msg = "timed out"
    end
    return nil, argv[1] .. ": " .. (msg ~= "" and msg or ("exit " .. tostring(r.code)))
  end
  return r.stdout
end

-- Open a directory in a new tab. In Rex a "window" is a tab inside a session, so
-- session.new_window == new tab.
function M.open_dir(dir, label)
  local w, err = rex.session.new_window {
    window_label = label and label:sub(1, 128) or nil,
    layout = rex.layout.block { flavor = M.SHELL, options = { cwd = dir } },
  }
  if w == nil then
    error("couldn't open " .. dir .. ": " .. tostring(err), 0)
  end
  return w
end

function M.bail(action, why)
  if why == "cancelled" then
    return
  end
  rex.log("warn", action .. ": " .. tostring(why))
end

return M
