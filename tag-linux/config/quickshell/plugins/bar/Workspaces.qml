import QtQuick
import Quickshell.Hyprland

import qs.Commons
import qs.Ui

Row {
    id: workspaces

    required property string monitorName

    spacing: 1

    Repeater {
        model: 9

        Rectangle {
            required property int index
            readonly property int workspaceId: index + 1
            readonly property var workspace: Hyprland.workspaces.values.find(candidate => candidate.id === workspaceId)
            readonly property bool onThisMonitor: workspace?.monitor?.name === workspaces.monitorName
            readonly property bool active: onThisMonitor && workspace.active
            readonly property bool occupied: onThisMonitor && workspace.toplevels.values.length > 0

            visible: workspaceId <= 5 || onThisMonitor
            width: 24
            height: Style.barHeight
            color: "transparent"
            opacity: active || occupied ? 1 : 0.5

            Label {
                anchors.centerIn: parent
                text: parent.active ? "" : parent.workspaceId
                color: parent.active ? Color.accent : Color.foreground
                font.family: Style.mixedFont
                font.pixelSize: 14
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("hl.dsp.focus { workspace = " + parent.workspaceId + " }")
            }
        }
    }
}
