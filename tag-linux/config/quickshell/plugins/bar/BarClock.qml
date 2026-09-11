import QtQuick
import Quickshell

import qs.Commons
import qs.Ui

Label {
    text: Qt.formatDateTime(clock.date, "HH:mm")
    color: Color.foreground
    font.family: Style.mixedFont
    font.pixelSize: 14
    font.bold: true

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
