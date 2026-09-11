import Quickshell
import Quickshell.Io

Scope {
    id: notificationsRoot

    property alias doNotDisturb: notificationState.doNotDisturb
    readonly property int notificationCount: notificationState.notificationCount

    function toggleHistory() {
        notificationHistoryWindow.visible = !notificationHistoryWindow.visible
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

    NotificationHistory {
        id: notificationHistoryWindow

        history: notificationState.history
        doNotDisturb: notificationsRoot.doNotDisturb
        onToggleDoNotDisturb: notificationsRoot.doNotDisturb = !notificationsRoot.doNotDisturb
        onClearRequested: notificationState.clearHistory()
    }

    NotificationPopups {
        notifications: notificationState.trackedNotifications
    }
}
