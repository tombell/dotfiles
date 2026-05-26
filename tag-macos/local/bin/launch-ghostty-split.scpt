if application "Ghostty" is running then
  tell application "System Events"
    click menu item "New Window" of menu "File" of menu bar 1 of process "Ghostty"
    tell application "Ghostty" to activate
  end tell
else
  tell application "Ghostty" to activate
end if

delay 0.4

tell application "System Events"
  tell process "Ghostty"
    set frontmost to true
    keystroke "d" using command down
  end tell
end tell
