import QtQuick
import Quickshell

import qs.Commons
import qs.Ui

Item {
    id: statusIcon

    required property string icon
    property string tooltipText: ""
    property var command: []
    property var clicked: null

    implicitWidth: 33
    implicitHeight: Style.barHeight

    IconLabel {
        anchors.centerIn: parent
        text: parent.icon
        color: Color.foreground
        font.pixelSize: 18
        font.bold: true
    }

    MouseArea {
        id: statusMouse

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: parent.command.length > 0 || parent.clicked ? Qt.PointingHandCursor : Qt.ArrowCursor
        onClicked: {
            if (parent.clicked)
                parent.clicked()
            else if (parent.command.length > 0)
                Quickshell.execDetached(parent.command)
        }
    }

    PopupWindow {
        visible: statusMouse.containsMouse && statusIcon.tooltipText !== ""
        color: "transparent"
        implicitWidth: tooltipLabel.implicitWidth + 22
        implicitHeight: tooltipLabel.implicitHeight + 16

        anchor {
            item: statusIcon
            edges: Edges.Bottom
            gravity: Edges.Bottom
        }

        PanelSurface {
            anchors.fill: parent
            anchors.margins: 1

            Label {
                id: tooltipLabel

                anchors.centerIn: parent
                text: statusIcon.tooltipText
                color: Color.foreground
                font.pixelSize: 13
                font.bold: true
            }
        }
    }
}
