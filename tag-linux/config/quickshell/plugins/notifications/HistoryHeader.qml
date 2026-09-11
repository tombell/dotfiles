import QtQuick

import qs.Commons
import qs.Ui

Row {
    id: historyHeader

    required property bool doNotDisturb

    signal toggleDoNotDisturb()
    signal clearRequested()

    height: 36

    Label {
        width: parent.width - dndButton.width - clearButton.width - 16
        anchors.verticalCenter: parent.verticalCenter
        text: "Notifications"
        color: Color.foregroundStrong
        font.pixelSize: 18
        font.bold: true
    }

    Button {
        id: dndButton

        width: 44
        height: 30
        color: historyHeader.doNotDisturb ? Color.accent : Color.subdued
        text: historyHeader.doNotDisturb ? "󰂛" : "󰂚"
        textColor: historyHeader.doNotDisturb ? Color.background : Color.foreground
        font.family: Style.iconFont
        font.pixelSize: 17
        font.bold: false
        onClicked: historyHeader.toggleDoNotDisturb()
    }

    Item { width: 8; height: 1 }

    Button {
        id: clearButton

        width: 44
        height: 30
        text: "󰆴"
        textColor: Color.foreground
        font.family: Style.iconFont
        font.pixelSize: 17
        font.bold: false
        onClicked: historyHeader.clearRequested()
    }
}
