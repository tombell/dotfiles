import Quickshell

import "plugins/bar"
import "plugins/launcher"
import "plugins/notifications"
import "plugins/osd"
import "plugins/wallpaper"

ShellRoot {
    Wallpaper {}

    NotificationCenter {
        id: notifications
    }

    Bar {
        doNotDisturb: notifications.doNotDisturb
        notificationCount: notifications.notificationCount
        onToggleHistory: notifications.toggleHistory()
    }

    Launcher {}
    Osd {}
}
