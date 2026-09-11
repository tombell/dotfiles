import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: notificationWindow

    required property var notifications

    visible: notificationWindow.notifications.values.length > 0
    color: "transparent"
    implicitWidth: 470
    implicitHeight: notificationColumn.implicitHeight
    exclusionMode: ExclusionMode.Ignore
    anchors {
        top: true
        right: true
    }
    margins {
        top: 10
        right: 10
    }

    WlrLayershell.namespace: "quickshell-notifications"

    Column {
        id: notificationColumn

        width: 450
        anchors.right: parent.right
        spacing: 10

        Repeater {
            model: notificationWindow.notifications

            NotificationPopup {
                required property var modelData

                notification: modelData
            }
        }
    }
}
