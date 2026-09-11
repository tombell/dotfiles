import QtQuick

import qs.Commons
import qs.Ui

Rectangle {
    id: applicationRow

    required property var entry
    required property bool selected

    signal hovered()
    signal activated()

    height: 56.8
    color: selected ? Color.subdued : "transparent"

    ApplicationIcon {
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        width: 28
        height: 28
        icon: applicationRow.entry.icon
    }

    Label {
        anchors.left: parent.left
        anchors.leftMargin: 52
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        text: applicationRow.entry.name
        color: applicationRow.selected ? Color.foregroundStrong : Color.foreground
        elide: Text.ElideRight
        font.pixelSize: 14
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: applicationRow.hovered()
        onClicked: applicationRow.activated()
    }
}
