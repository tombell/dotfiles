import QtQuick
import qs.Commons

Rectangle {
    property real value: 0
    property color fillColor: Color.accent

    color: Color.subdued
    radius: height / 2
    clip: true

    Rectangle {
        width: parent.width * Math.max(0, Math.min(1, parent.value))
        height: parent.height
        color: parent.fillColor
        radius: parent.radius
    }
}
