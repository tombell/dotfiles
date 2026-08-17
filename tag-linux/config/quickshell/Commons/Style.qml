pragma Singleton
import QtQuick

QtObject {
    readonly property string textFont: "SF Compact Display"
    readonly property string iconFont: "IosevkaTerm Nerd Font Propo"
    readonly property string mixedFont: textFont + ", " + iconFont

    readonly property int barHeight: 35
    readonly property int cornerRadius: 5
    readonly property int controlRadius: 4
    readonly property int progressRadius: 2
}
