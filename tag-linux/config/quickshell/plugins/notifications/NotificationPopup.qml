import QtQuick
import Quickshell.Services.Notifications

import qs.Commons
import qs.Ui

PanelSurface {
    id: notificationItem

    required property var notification
    readonly property bool critical: notificationItem.notification.urgency === NotificationUrgency.Critical
    readonly property var defaultAction: notificationItem.notification.actions.find(action => action.identifier === "default")
    readonly property real progress: {
        const value = notificationItem.notification.hints["value"]
        return value === undefined ? -1 : Math.max(0, Math.min(1, Number(value) / 100))
    }

    width: 450
    height: notificationContent.implicitHeight + 30 + (progress >= 0 ? 8 : 0)
    border.color: critical ? Color.urgent : Color.accent

    Timer {
        interval: notificationItem.notification.expireTimeout > 0 ? notificationItem.notification.expireTimeout : 5000
        running: !notificationItem.critical
        onTriggered: notificationItem.notification.expire()
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                notificationItem.notification.dismiss()
            } else if (notificationItem.defaultAction) {
                notificationItem.defaultAction.invoke()
            } else {
                notificationItem.notification.dismiss()
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

        ApplicationIcon {
            id: notificationImage

            width: visible ? 50 : 0
            height: 50
            visible: source.toString() !== ""
            icon: notificationItem.notification.appIcon
            imageSource: notificationItem.notification.image
        }

        Column {
            width: notificationItem.width - 30 - notificationContent.spacing - (notificationImage.visible ? 50 : 0)
            spacing: 5

            Label {
                width: parent.width
                text: notificationItem.notification.summary || notificationItem.notification.appName
                color: notificationItem.critical ? Color.urgent : Color.foregroundStrong
                font.pixelSize: 14
                font.bold: true
                wrapMode: Text.Wrap
            }

            Label {
                width: parent.width
                visible: text !== ""
                text: notificationItem.notification.body
                wrapMode: Text.Wrap
                textFormat: Text.StyledText
            }

            NotificationActions {
                actions: notificationItem.notification.actions
            }
        }
    }

    ProgressBar {
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
        value: notificationItem.progress
        fillColor: notificationItem.critical ? Color.urgent : Color.accent
    }
}
