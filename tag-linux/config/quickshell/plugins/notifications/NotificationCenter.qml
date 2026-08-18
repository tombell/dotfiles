import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Notifications
import Quickshell.Wayland
import Quickshell.Widgets

import qs.Commons
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

    HyprlandFocusGrab {
        windows: [notificationHistoryWindow]
        active: notificationHistoryWindow.visible
        onCleared: notificationHistoryWindow.visible = false
    }

    PanelWindow {
        id: notificationHistoryWindow

        visible: false
        color: "transparent"
        implicitWidth: 350
        implicitHeight: 500
        exclusionMode: ExclusionMode.Ignore
        anchors {
            top: true
            right: true
        }
        margins.top: Style.barHeight

        WlrLayershell.namespace: "quickshell-notification-history"

        Rectangle {
            anchors.fill: parent
            color: Color.background
            border.color: Color.accent
            border.width: 1
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
                    color: Color.foregroundStrong
                    font.family: Style.textFont
                    font.pixelSize: 18
                    font.bold: true
                }

                Rectangle {
                    id: dndButton
                    width: 44
                    height: 30
                    color: notificationsRoot.doNotDisturb ? Color.accent : Color.subdued
                    radius: Style.controlRadius

                    Text {
                        anchors.centerIn: parent
                        text: notificationsRoot.doNotDisturb ? "󰂛" : "󰂚"
                        color: notificationsRoot.doNotDisturb ? Color.background : Color.foreground
                        font.family: Style.iconFont
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
                    color: Color.subdued
                    radius: Style.controlRadius

                    Text {
                        anchors.centerIn: parent
                        text: "󰆴"
                        color: Color.foreground
                        font.family: Style.iconFont
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
                color: Color.subdued
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
                    color: Color.surface
                    border.color: critical ? Color.urgent : Color.subdued
                    border.width: 1
                    radius: Style.cornerRadius

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
                                color: critical ? Color.urgent : Color.foregroundStrong
                                font.family: Style.textFont
                                font.pixelSize: 13
                                font.bold: true
                                wrapMode: Text.Wrap
                            }

                            Text {
                                width: parent.width
                                visible: body !== ""
                                text: body
                                color: Color.foreground
                                font.family: Style.textFont
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
                    color: Color.muted
                    font.family: Style.textFont
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
                    color: Color.background
                    border.color: critical ? Color.urgent : Color.accent
                    border.width: 1
                    radius: Style.cornerRadius

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
                                color: notificationItem.critical ? Color.urgent : Color.foregroundStrong
                                font.family: Style.textFont
                                font.pixelSize: 14
                                font.bold: true
                                wrapMode: Text.Wrap
                            }

                            Text {
                                width: parent.width
                                visible: text !== ""
                                text: modelData.body
                                color: Color.foreground
                                font.family: Style.textFont
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
                                        color: Color.subdued
                                        radius: Style.controlRadius

                                        Text {
                                            id: actionText
                                            anchors.centerIn: parent
                                            text: modelData.text
                                            color: Color.foregroundStrong
                                            font.family: Style.textFont
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
                        color: Color.subdued
                        radius: Style.progressRadius

                        Rectangle {
                            width: parent.width * notificationItem.progress
                            height: parent.height
                            color: notificationItem.critical ? Color.urgent : Color.accent
                        }
                    }
                }
            }
        }
    }

}
