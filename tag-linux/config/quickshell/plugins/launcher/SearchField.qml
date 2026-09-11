import QtQuick

import qs.Commons
import qs.Ui

Rectangle {
    id: searchField

    property alias text: searchInput.text

    signal dismissRequested()
    signal previousRequested()
    signal nextRequested()
    signal launchRequested()

    height: 54
    color: Color.surface

    function focusInput() {
        searchInput.forceActiveFocus()
    }

    Label {
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        text: "Apps"
        color: Color.accent
        font.pixelSize: 14
        font.bold: true
    }

    TextInput {
        id: searchInput

        anchors.left: parent.left
        anchors.leftMargin: 58
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.verticalCenter: parent.verticalCenter
        color: Color.foregroundStrong
        selectionColor: Color.subdued
        font.pixelSize: 14
        font.bold: true
        clip: true
        Keys.onEscapePressed: searchField.dismissRequested()
        Keys.onUpPressed: searchField.previousRequested()
        Keys.onDownPressed: searchField.nextRequested()
        Keys.onReturnPressed: searchField.launchRequested()
        Keys.onEnterPressed: searchField.launchRequested()
    }
}
