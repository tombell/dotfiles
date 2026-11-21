-- custom_ui — Rex custom actions for Tom (Lua 5.1, loaded by Rex's init.lua).
--
-- Each feature lives in its own file in this directory (all actions appear in the command
-- palette; `rex actions` lists them):
--   util.lua       shared config (M.config) and helpers
--   repo.lua       focused terminal's directory, repo discovery/picking
--   projects.lua   project_switch   Open a repo under ~/Code in a new tab
--   github.lua     pr_checkout      Pick an open PR (gh) and type `gh pr checkout N` into the terminal
--   worktrees.lua  worktree_jump    Pick a git worktree and open it in a new tab
--   commit.lua     stage_commit     Multi-select changed files, ask for a message, git add + git commit
--   swm.lua        swm, swm_reload  Picker of real swm CLI commands (and a one-shot reload)
--   confirm.lua    confirm_deploy   Example approval prompt that `rex do` can wait on
--   debug.lua      cwd_debug        Dumps what Rex reports for the focused terminal's directory
--
-- Install: link this directory to ~/.config/rex/custom_ui, then in ~/.config/rex/init.lua:
--   require("custom_ui").bind_defaults()   -- or just require("custom_ui") and bind keys yourself
--   -- then:  rex config check && rex config reload
--
-- Every API used is from the Rex docs (config, custom actions, custom UI, Lua API reference,
-- events). Things the docs do NOT specify are marked "UNVERIFIED".

local util = require("custom_ui.util")

require("custom_ui.projects")
require("custom_ui.github")
require("custom_ui.worktrees")
require("custom_ui.commit")
require("custom_ui.swm")
require("custom_ui.debug")

local M = {}
M.config = util.config
M.confirm = require("custom_ui.confirm").confirm

----------------------------------------------------------------------------------------------
-- Key bindings
-- Rex's defaults use cmd, alt+cmd, shift+cmd, alt+shift+cmd and ctrl+cmd+{f,i}; none uses
-- ctrl+alt+cmd. These are unbound until you call require("custom_ui").bind_defaults().
-- (If skbd/swm hotkeys already use ctrl+alt+cmd+<letter>, change them here — they are only
-- checked against Rex's own defaults.)
----------------------------------------------------------------------------------------------
function M.bind_defaults()
  rex.bind("ctrl+alt+cmd+p", "project_switch")   -- [P]rojects
  rex.bind("ctrl+alt+cmd+r", "pr_checkout")      -- PR / [R]eview
  rex.bind("ctrl+alt+cmd+w", "worktree_jump")    -- [W]orktrees
  rex.bind("ctrl+alt+cmd+c", "stage_commit")     -- [C]ommit
  rex.bind("ctrl+alt+cmd+s", "swm")              -- [S]wm
  -- rex.bind("ctrl+alt+cmd+l", "swm_reload")    -- re[L]oad swm config
  -- rex.bind("ctrl+alt+cmd+d", "confirm_deploy", { target = "staging" })
end

return M
