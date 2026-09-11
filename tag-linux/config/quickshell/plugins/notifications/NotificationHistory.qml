import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

import qs.Commons
import qs.Ui

PanelWindow {
    id: notificationHistoryWindow

    required property var history
    required property bool doNotDisturb

    signal toggleDoNotDisturb()
    signal clearRequested()

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

    HyprlandFocusGrab {
        windows: [notificationHistoryWindow]
        active: notificationHistoryWindow.visible
        onCleared: notificationHistoryWindow.visible = false
    }

    PanelSurface {
        anchors.fill: parent
    }

    Column {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 12

        HistoryHeader {
            width: parent.width
            doNotDisturb: notificationHistoryWindow.doNotDisturb
            onToggleDoNotDisturb: notificationHistoryWindow.toggleDoNotDisturb()
            onClearRequested: notificationHistoryWindow.clearRequested()
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
            model: notificationHistoryWindow.history

            delegate: HistoryItem {
                width: ListView.view.width
            }

            Label {
                anchors.centerIn: parent
                visible: notificationHistoryWindow.history.count === 0
                text: "No notifications"
                color: Color.muted
                font.pixelSize: 14
            }
        }
    }
}
