import QtQuick
import Quickshell

import qs.Commons
import qs.Ui

Item {
    id: statusIcon

    required property string icon
    property string tooltipText: ""

    signal clicked()

    implicitWidth: 33
    implicitHeight: Style.barHeight

    IconLabel {
        anchors.centerIn: parent
        text: statusIcon.icon
        font.bold: true
    }

    MouseArea {
        id: statusMouse

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: statusIcon.clicked()
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
                font.bold: true
            }
        }
    }
}
