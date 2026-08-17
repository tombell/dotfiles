import Quickshell

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
