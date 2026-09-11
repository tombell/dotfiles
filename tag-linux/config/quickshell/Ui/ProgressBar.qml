import QtQuick

import qs.Commons

Rectangle {
    id: progressBar

    property real value: 0
    property color fillColor: Color.accent

    color: Color.subdued
    radius: height / 2
    clip: true

    Rectangle {
        width: parent.width * Math.max(0, Math.min(1, progressBar.value))
        height: parent.height
        color: progressBar.fillColor
        radius: parent.radius
    }
}
