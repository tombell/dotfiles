import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.UPower

import qs.Commons
import qs.Ui

StatusIcon {
    id: batteryIcon

    required property real power

    readonly property var battery: UPower.displayDevice
    readonly property int percentage: battery ? Math.round(battery.percentage * 100) : 0
    readonly property real remainingSeconds: UPower.onBattery ? battery?.timeToEmpty ?? 0 : battery?.timeToFull ?? 0
    readonly property string remainingText: {
        if (remainingSeconds <= 0) return "Estimating…"
        const hours = Math.floor(remainingSeconds / 3600)
        const minutes = Math.floor((remainingSeconds % 3600) / 60)
        return hours > 0 ? hours + "h " + minutes + "m" : minutes + "m"
    }

    icon: {
        if (!battery || !battery.ready) return ""
        if (!UPower.onBattery) return percentage >= 100 ? "󰂅" : ""
        const icons = ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
        return icons[Math.min(9, Math.floor(percentage / 10))]
    }
    tooltipText: batteryIcon.power.toFixed(1) + "W" + (UPower.onBattery ? "↓ " : "↑ ") + percentage + "%"
    onClicked: batteryPopup.visible = !batteryPopup.visible

    HyprlandFocusGrab {
        windows: [batteryPopup]
        active: batteryPopup.visible
        onCleared: batteryPopup.visible = false
    }

    PopupWindow {
        id: batteryPopup

        visible: false
        color: "transparent"
        grabFocus: true
        implicitWidth: 302
        implicitHeight: 192

        anchor {
            item: batteryIcon
            edges: Edges.Bottom
            gravity: Edges.Bottom
        }

        PanelSurface {
            anchors.fill: parent
            anchors.margins: 1

            Column {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 12

                Row {
                    width: parent.width

                    Label {
                        width: parent.width / 2
                        text: batteryIcon.percentage + "%"
                        color: Color.foregroundStrong
                        font.pixelSize: 24
                        font.bold: true
                    }

                    Label {
                        width: parent.width / 2
                        horizontalAlignment: Text.AlignRight
                        text: batteryIcon.power.toFixed(1) + " W"
                        font.pixelSize: 16
                        font.bold: true
                    }
                }

                Label {
                    text: (UPower.onBattery ? "Remaining: " : "Until full: ") + batteryIcon.remainingText
                }

                ProgressBar {
                    width: parent.width
                    height: 8
                    value: batteryIcon.percentage / 100
                }

                Label {
                    text: "Power profile"
                    color: Color.foregroundStrong
                    font.bold: true
                }

                Row {
                    spacing: 8

                    Repeater {
                        model: [
                            { "label": "Saver", "profile": PowerProfile.PowerSaver },
                            { "label": "Balanced", "profile": PowerProfile.Balanced },
                            { "label": "Performance", "profile": PowerProfile.Performance }
                        ]

                        Button {
                            required property var modelData
                            readonly property bool selected: PowerProfiles.profile === modelData.profile

                            visible: modelData.profile !== PowerProfile.Performance || PowerProfiles.hasPerformanceProfile
                            width: 82
                            height: 32
                            color: selected ? Color.accent : Color.subdued
                            text: modelData.label
                            textColor: selected ? Color.background : Color.foreground
                            onClicked: PowerProfiles.profile = modelData.profile
                        }
                    }
                }
            }
        }
    }
}
