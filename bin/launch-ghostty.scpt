if application "Ghostty" is running then
  tell application "System Events"
    click menu item "New Window" of menu "File" of menu bar 1 of process "Ghostty"
  end tell
else
  tell application "Ghostty" to activate
end if
