-- Key sequences carried over from my old Herdr setup (prefix ctrl+b).

local prefix = "ctrl+b"

local function seq(key, action, args)
  rex.bind(prefix .. ">" .. key, action, args)
end

-- Send a literal ctrl+b by pressing it twice.
seq(prefix, "pane.send_key", { key = prefix })

-- Sessions (Herdr workspaces)
seq("g", "session.switch")
seq("w", "session.switch")
seq("shift+n", "session.new")
seq("shift+w", "session.rename")
seq("shift+d", "session.close")
rex.bind("alt+shift+[", "session.previous")
rex.bind("alt+shift+]", "session.next")

-- Tabs
seq("c", "client.tab.new")
seq("n", "client.tab.next")
seq("p", "client.tab.previous")
seq("shift+t", "client.tab.rename")
seq("shift+x", "client.tab.close")
for i = 1, 9 do
  seq(tostring(i), "client.tab.goto", { index = i })
end
rex.bind("cmd+shift+[", "client.tab.previous")
rex.bind("cmd+shift+]", "client.tab.next")

-- Panes
seq("v", "pane.split.right")
seq("-", "pane.split.down")
seq("x", "pane.close")
seq("z", "pane.zoom")
seq("shift+p", "pane.rename")
seq("[", "pane.copy_mode.enter")
seq("tab", "pane.focus_next")
seq("shift+tab", "pane.focus_previous")

for key, dir in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  seq(key, "pane.focus." .. dir)
  seq("shift+" .. key, "pane.move." .. dir)
end

-- Jump to anything (was herdr-navigator)
seq("t", "pane.go_to")

-- Misc
seq("b", "client.sidebar.toggle")
seq("s", "client.settings")
seq("shift+r", "client.config.reload")
