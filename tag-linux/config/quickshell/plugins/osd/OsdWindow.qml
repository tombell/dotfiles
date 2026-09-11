import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.Commons
import qs.Ui

PanelWindow {
    id: osdWindow

    property string osdIcon: ""
    property real osdValue: 0
    property bool osdMuted: false

    visible: false
    color: "transparent"
    implicitWidth: 262
    implicitHeight: 60
    exclusionMode: ExclusionMode.Ignore
    anchors.bottom: true
    margins.bottom: 80

    WlrLayershell.namespace: "quickshell-osd"

    function showOsd(icon, value, muted) {
        osdWindow.osdValue = value
        osdWindow.osdMuted = muted
        osdWindow.osdIcon = icon
        osdWindow.visible = true
        osdHide.restart()
    }

    Timer {
        id: osdHide
        interval: 1500
        onTriggered: osdWindow.visible = false
    }

    PanelSurface {
        anchors.fill: parent
        anchors.margins: 1

        IconLabel {
            anchors.left: parent.left
            anchors.leftMargin: 18
            anchors.verticalCenter: parent.verticalCenter
            text: osdWindow.osdIcon
            color: osdWindow.osdMuted ? Color.urgent : Color.foreground
            font.pixelSize: 22
        }

        ProgressBar {
            anchors.left: parent.left
            anchors.leftMargin: 58
            anchors.right: parent.right
            anchors.rightMargin: 18
            anchors.verticalCenter: parent.verticalCenter
            height: 8
            value: osdWindow.osdValue
            fillColor: osdWindow.osdMuted ? Color.urgent : Color.accent
        }
    }
}
