import QtQuick

import qs.Commons
import qs.Ui

PanelSurface {
    id: historyItem

    required property string appName
    required property string summary
    required property string body
    required property string icon
    required property bool critical

    height: historyContent.implicitHeight + 24
    color: Color.surface
    border.color: historyItem.critical ? Color.urgent : Color.subdued

    Row {
        id: historyContent
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 12
        }
        spacing: 10

        ApplicationIcon {
            width: 36
            height: 36
            icon: historyItem.icon
        }

        Column {
            width: parent.width - 46
            spacing: 4

            Label {
                width: parent.width
                text: historyItem.summary || historyItem.appName
                color: historyItem.critical ? Color.urgent : Color.foregroundStrong
                font.bold: true
                wrapMode: Text.Wrap
            }

            Label {
                width: parent.width
                visible: historyItem.body !== ""
                text: historyItem.body
                font.pixelSize: 12
                wrapMode: Text.Wrap
                textFormat: Text.StyledText
            }
        }
    }
}
