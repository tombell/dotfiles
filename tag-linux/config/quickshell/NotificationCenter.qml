import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import Quickshell.Wayland
import Quickshell.Widgets

Scope {
    id: notificationsRoot

    property bool doNotDisturb: false
    readonly property int notificationCount: notificationHistory.count

    function toggleHistory() {
        notificationHistoryWindow.visible = !notificationHistoryWindow.visible
    }

    function applicationIcon(icon) {
        if (icon === "network-wired")
            return "file:///usr/share/icons/Adwaita/symbolic/devices/network-wired-symbolic.svg"
        if (icon && (icon.startsWith("/") || Quickshell.hasThemeIcon(icon)))
            return Quickshell.iconPath(icon)
        return "file:///usr/share/icons/Adwaita/scalable/mimetypes/application-x-executable.svg"
    }

    ListModel {
        id: notificationHistory
    }

    IpcHandler {
        target: "notifications"

        function toggleHistory(): void { notificationHistoryWindow.visible = !notificationHistoryWindow.visible }
        function toggleDoNotDisturb(): void { notificationsRoot.doNotDisturb = !notificationsRoot.doNotDisturb }
        function clear(): void { notificationHistory.clear() }
    }

    PanelWindow {
        id: notificationHistoryWindow

        visible: false
        color: "transparent"
        implicitWidth: 400
        exclusionMode: ExclusionMode.Ignore
        anchors {
            top: true
            bottom: true
            right: true
        }
        margins.top: 35

        WlrLayershell.namespace: "quickshell-notification-history"

        Rectangle {
            anchors.fill: parent
            color: "#1a1b26"
            border.color: "#c7a9ff"
            border.width: 2
        }

        Column {
            anchors.fill: parent
            anchors.margins: 15
            spacing: 12

            Row {
                width: parent.width
                height: 36

                Text {
                    width: parent.width - dndButton.width - clearButton.width - 16
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Notifications"
                    color: "#c0caf5"
                    font.family: "SF Compact Display"
                    font.pixelSize: 18
                    font.bold: true
                }

                Rectangle {
                    id: dndButton
                    width: 44
                    height: 30
                    color: notificationsRoot.doNotDisturb ? "#c7a9ff" : "#414868"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: notificationsRoot.doNotDisturb ? "󰂛" : "󰂚"
                        color: notificationsRoot.doNotDisturb ? "#1a1b26" : "#a9b1d6"
                        font.family: "IosevkaTerm Nerd Font Propo"
                        font.pixelSize: 17
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: notificationsRoot.doNotDisturb = !notificationsRoot.doNotDisturb
                    }
                }

                Item { width: 8; height: 1 }

                Rectangle {
                    id: clearButton
                    width: 44
                    height: 30
                    color: "#414868"
                    radius: 4

                    Text {
                        anchors.centerIn: parent
                        text: "󰆴"
                        color: "#a9b1d6"
                        font.family: "IosevkaTerm Nerd Font Propo"
                        font.pixelSize: 17
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: notificationHistory.clear()
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#414868"
            }

            ListView {
                width: parent.width
                height: parent.height - 49
                spacing: 10
                clip: true
                model: notificationHistory

                delegate: Rectangle {
                    required property string appName
                    required property string summary
                    required property string body
                    required property string icon
                    required property bool critical

                    width: ListView.view.width
                    height: historyContent.implicitHeight + 24
                    color: "#15161e"
                    border.color: critical ? "#ff899d" : "#414868"
                    border.width: 1
                    radius: 5

                    Row {
                        id: historyContent
                        anchors {
                            left: parent.left
                            right: parent.right
                            top: parent.top
                            margins: 12
                        }
                        spacing: 10

                        IconImage {
                            width: 36
                            height: 36
                            source: notificationsRoot.applicationIcon(icon)
                        }

                        Column {
                            width: parent.width - 46
                            spacing: 4

                            Text {
                                width: parent.width
                                text: summary || appName
                                color: critical ? "#ff899d" : "#c0caf5"
                                font.family: "SF Compact Display"
                                font.pixelSize: 13
                                font.bold: true
                                wrapMode: Text.Wrap
                            }

                            Text {
                                width: parent.width
                                visible: body !== ""
                                text: body
                                color: "#a9b1d6"
                                font.family: "SF Compact Display"
                                font.pixelSize: 12
                                wrapMode: Text.Wrap
                                textFormat: Text.PlainText
                            }
                        }
                    }
                }

                Text {
                    anchors.centerIn: parent
                    visible: notificationHistory.count === 0
                    text: "No notifications"
                    color: "#565f89"
                    font.family: "SF Compact Display"
                    font.pixelSize: 14
                }
            }
        }
    }

    NotificationServer {
        id: notificationServer

        keepOnReload: true
        bodySupported: true
        bodyMarkupSupported: false
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
            notification.tracked = !notificationsRoot.doNotDisturb
        }
    }

    PanelWindow {
        id: notificationWindow

        visible: notificationServer.trackedNotifications.values.length > 0
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
                model: notificationServer.trackedNotifications

                Rectangle {
                    id: notificationItem

                    required property var modelData
                    readonly property bool critical: modelData.urgency === NotificationUrgency.Critical
                    readonly property var defaultAction: modelData.actions.find(action => action.identifier === "default")
                    readonly property real progress: {
                        const value = modelData.hints["value"]
                        return value === undefined ? -1 : Math.max(0, Math.min(1, Number(value) / 100))
                    }

                    width: 450
                    height: notificationContent.implicitHeight + 30 + (progress >= 0 ? 8 : 0)
                    color: "#1a1b26"
                    border.color: critical ? "#ff899d" : "#c7a9ff"
                    border.width: 2
                    radius: 5

                    Timer {
                        interval: modelData.expireTimeout > 0 ? modelData.expireTimeout : 5000
                        running: !notificationItem.critical
                        onTriggered: modelData.expire()
                    }

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: mouse => {
                            if (mouse.button === Qt.RightButton) {
                                modelData.dismiss()
                            } else if (notificationItem.defaultAction) {
                                notificationItem.defaultAction.invoke()
                            } else {
                                modelData.dismiss()
                            }
                        }
                    }

                    Row {
                        id: notificationContent

                        anchors {
                            top: parent.top
                            left: parent.left
                            right: parent.right
                            margins: 15
                        }
                        spacing: 12

                        IconImage {
                            width: visible ? 50 : 0
                            height: 50
                            visible: source.toString() !== ""
                            source: modelData.image || notificationsRoot.applicationIcon(modelData.appIcon)
                        }

                        Column {
                            width: notificationItem.width - 30 - notificationContent.spacing - (notificationContent.children[0].visible ? 50 : 0)
                            spacing: 5

                            Text {
                                width: parent.width
                                text: modelData.summary || modelData.appName
                                color: notificationItem.critical ? "#ff899d" : "#c0caf5"
                                font.family: "SF Compact Display"
                                font.pixelSize: 14
                                font.bold: true
                                wrapMode: Text.Wrap
                            }

                            Text {
                                width: parent.width
                                visible: text !== ""
                                text: modelData.body
                                color: "#a9b1d6"
                                font.family: "SF Compact Display"
                                font.pixelSize: 13
                                wrapMode: Text.Wrap
                                textFormat: Text.PlainText
                            }

                            Row {
                                spacing: 8
                                visible: modelData.actions.filter(action => action.identifier !== "default").length > 0

                                Repeater {
                                    model: modelData.actions.filter(action => action.identifier !== "default")

                                    Rectangle {
                                        required property var modelData

                                        width: actionText.implicitWidth + 16
                                        height: 28
                                        color: "#414868"
                                        radius: 4

                                        Text {
                                            id: actionText
                                            anchors.centerIn: parent
                                            text: modelData.text
                                            color: "#c0caf5"
                                            font.family: "SF Compact Display"
                                            font.pixelSize: 12
                                            font.bold: true
                                        }

                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: modelData.invoke()
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        visible: notificationItem.progress >= 0
                        anchors {
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                            leftMargin: 4
                            rightMargin: 4
                            bottomMargin: 4
                        }
                        height: 4
                        color: "#414868"
                        radius: 2

                        Rectangle {
                            width: parent.width * notificationItem.progress
                            height: parent.height
                            color: notificationItem.critical ? "#ff899d" : "#c7a9ff"
                        }
                    }
                }
            }
        }
    }

}
