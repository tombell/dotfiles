import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Scope {
    id: notificationState

    property bool doNotDisturb: false
    property alias history: notificationHistory
    readonly property int notificationCount: notificationHistory.count
    readonly property var trackedNotifications: notificationServer.trackedNotifications

    function clearHistory() {
        notificationHistory.clear()
    }

    ListModel {
        id: notificationHistory
    }

    NotificationServer {
        id: notificationServer

        keepOnReload: true
        bodySupported: true
        bodyMarkupSupported: true
        actionsSupported: true
        imageSupported: true
        persistenceSupported: true
        onNotification: notification => {
            notificationHistory.insert(0, {
                "appName": notification.appName,
                "summary": notification.summary,
                "body": notification.body,
                "icon": notification.appIcon,
                "critical": notification.urgency === NotificationUrgency.Critical
            })
            if (notificationHistory.count > 100)
                notificationHistory.remove(100, notificationHistory.count - 100)
            notification.tracked = !notificationState.doNotDisturb
        }
    }
}
