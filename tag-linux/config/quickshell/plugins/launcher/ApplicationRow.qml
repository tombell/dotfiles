import QtQuick
import Quickshell
import Quickshell.Widgets

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

    function applicationIcon(icon) {
        if (icon === "network-wired")
            return "file:///usr/share/icons/Adwaita/symbolic/devices/network-wired-symbolic.svg"
        if (icon && (icon.startsWith("/") || Quickshell.hasThemeIcon(icon)))
            return Quickshell.iconPath(icon)
        return "file:///usr/share/icons/Adwaita/scalable/mimetypes/application-x-executable.svg"
    }

    IconImage {
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        width: 28
        height: 28
        source: applicationRow.applicationIcon(applicationRow.entry.icon)
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
