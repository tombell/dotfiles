import QtQuick

import qs.Commons

Rectangle {
    id: button

    required property string text
    property alias font: label.font
    property alias textColor: label.color

    signal clicked()

    implicitWidth: label.implicitWidth + 16
    implicitHeight: 28
    color: Color.subdued
    radius: Style.controlRadius

    Label {
        id: label

        anchors.centerIn: parent
        text: button.text
        color: Color.foregroundStrong
        font.pixelSize: 12
        font.bold: true
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: button.clicked()
    }
}
