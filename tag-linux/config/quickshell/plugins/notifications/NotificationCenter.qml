import Quickshell
import Quickshell.Io

Scope {
    id: notificationsRoot

    property alias doNotDisturb: notificationState.doNotDisturb
    readonly property int notificationCount: notificationState.notificationCount

    function toggleHistory() {
        historyLoader.active = !historyLoader.active
    }

    IpcHandler {
        target: "notifications"

        function toggleHistory(): void { notificationsRoot.toggleHistory() }
        function toggleDoNotDisturb(): void { notificationsRoot.doNotDisturb = !notificationsRoot.doNotDisturb }
        function clear(): void { notificationState.clearHistory() }
    }

    NotificationState {
        id: notificationState
    }

    LazyLoader {
        id: historyLoader

        active: false

        NotificationHistory {
            history: notificationState.history
            doNotDisturb: notificationsRoot.doNotDisturb
            onToggleDoNotDisturb: notificationsRoot.doNotDisturb = !notificationsRoot.doNotDisturb
            onClearRequested: notificationState.clearHistory()
            onDismissRequested: historyLoader.active = false
        }
    }

    NotificationPopups {
        notifications: notificationState.trackedNotifications
    }
}
