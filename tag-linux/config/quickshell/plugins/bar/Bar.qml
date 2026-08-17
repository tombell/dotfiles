import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import Quickshell.Wayland

Scope {
    id: barRoot

    property bool doNotDisturb: false
    property int notificationCount: 0
    signal toggleHistory()

    readonly property var audioSink: Pipewire.defaultAudioSink
    readonly property var audioSource: Pipewire.defaultAudioSource
    property string networkIcon: "󰖪"
    property string networkTooltip: "Disconnected"
    property double previousRxBytes: 0
    property double previousTxBytes: 0
    property double batteryPower: 0

    function formatRate(bytesPerSecond) {
        if (bytesPerSecond >= 1073741824) return (bytesPerSecond / 1073741824).toFixed(1) + " GiB/s"
        if (bytesPerSecond >= 1048576) return (bytesPerSecond / 1048576).toFixed(1) + " MiB/s"
        if (bytesPerSecond >= 1024) return (bytesPerSecond / 1024).toFixed(1) + " KiB/s"
        return Math.round(bytesPerSecond) + " B/s"
    }

    PwObjectTracker {
        objects: [barRoot.audioSink, barRoot.audioSource].filter(object => object !== null)
    }

    Process {
        id: networkStatus
        command: ["sh", "-c", "iface=$(ip route show default | awk 'NR==1 {print $5}'); if [ -z \"$iface\" ]; then echo 'disconnected'; else rx=$(cat /sys/class/net/$iface/statistics/rx_bytes); tx=$(cat /sys/class/net/$iface/statistics/tx_bytes); if [ -d /sys/class/net/$iface/wireless ]; then quality=$(awk 'NR==3 {print int($3)}' /proc/net/wireless); info=$(iwctl station \"$iface\" show 2>/dev/null | sed 's/\\x1b\\[[0-9;]*m//g'); ssid=$(printf '%s\\n' \"$info\" | awk '/Connected network/ {$1=$2=\"\"; sub(/^  */,\"\"); print; exit}'); freq=$(printf '%s\\n' \"$info\" | awk '/Frequency/ {print $2; exit}'); printf 'wifi|%s|%s|%s|%s|%s\\n' \"$quality\" \"$ssid\" \"$freq\" \"$rx\" \"$tx\"; else printf 'ethernet|%s|%s\\n' \"$rx\" \"$tx\"; fi; fi"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const status = text.trim()
                if (status === "disconnected" || status === "") {
                    barRoot.networkIcon = "󰖪"
                    barRoot.networkTooltip = "Disconnected"
                } else {
                    const fields = status.split("|")
                    const wifi = fields[0] === "wifi"
                    const rx = Number(fields[wifi ? 4 : 1])
                    const tx = Number(fields[wifi ? 5 : 2])
                    const down = barRoot.previousRxBytes > 0 ? Math.max(0, rx - barRoot.previousRxBytes) / 5 : 0
                    const up = barRoot.previousTxBytes > 0 ? Math.max(0, tx - barRoot.previousTxBytes) / 5 : 0
                    barRoot.previousRxBytes = rx
                    barRoot.previousTxBytes = tx

                    if (wifi) {
                        const quality = Number(fields[1])
                        const frequency = Number(fields[3]) / 1000
                        barRoot.networkIcon = quality < 20 ? "󰤯" : quality < 40 ? "󰤟" : quality < 55 ? "󰤢" : quality < 70 ? "󰤥" : "󰤨"
                        barRoot.networkTooltip = fields[2] + (frequency ? " (" + frequency.toFixed(2) + " GHz)" : "")
                    } else {
                        barRoot.networkIcon = "󰀂"
                        barRoot.networkTooltip = "Ethernet"
                    }
                    barRoot.networkTooltip += "\n⇣ " + barRoot.formatRate(down) + " ⇡ " + barRoot.formatRate(up)
                }
            }
        }
    }

    Process {
        id: batteryStatus
        command: ["sh", "-c", "battery=$(find /sys/class/power_supply -maxdepth 1 -name 'BAT*' | head -1); if [ -r \"$battery/power_now\" ]; then awk '{print $1 / 1000000}' \"$battery/power_now\"; elif [ -r \"$battery/current_now\" ] && [ -r \"$battery/voltage_now\" ]; then awk 'NR==FNR {current=$1; next} {print current * $1 / 1000000000000}' \"$battery/current_now\" \"$battery/voltage_now\"; else echo 0; fi"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: barRoot.batteryPower = Number(text.trim()) || 0
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            networkStatus.running = true
            batteryStatus.running = true
        }
    }

    component StatusIcon: Item {
        id: statusIcon

        required property string icon
        property string tooltipText: ""
        property var command: []
        property var clicked: null

        implicitWidth: 33
        implicitHeight: 35

        Text {
            anchors.centerIn: parent
            text: parent.icon
            color: "#a9b1d6"
            font.family: "IosevkaTerm Nerd Font Propo"
            font.pixelSize: 18
            font.bold: true
        }

        MouseArea {
            id: statusMouse

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: parent.command.length > 0 || parent.clicked ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: {
                if (parent.clicked)
                    parent.clicked()
                else if (parent.command.length > 0)
                    Quickshell.execDetached(parent.command)
            }
        }

        PopupWindow {
            visible: statusMouse.containsMouse && statusIcon.tooltipText !== ""
            color: "transparent"
            implicitWidth: tooltipLabel.implicitWidth + 20
            implicitHeight: tooltipLabel.implicitHeight + 14

            anchor {
                item: statusIcon
                edges: Edges.Bottom
                gravity: Edges.Bottom
            }

            Rectangle {
                anchors.fill: parent
                color: "#1a1b26"
                border.color: "#c7a9ff"
                border.width: 1
                radius: 5

                Text {
                    id: tooltipLabel

                    anchors.centerIn: parent
                    text: statusIcon.tooltipText
                    color: "#a9b1d6"
                    font.family: "SF Compact Display"
                    font.pixelSize: 13
                    font.bold: true
                }
            }
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow

            required property var modelData

            screen: modelData
            color: "#1a1b26"
            implicitHeight: 35
            anchors {
                top: true
                left: true
                right: true
            }

            WlrLayershell.namespace: "quickshell-bar"

            Item {
                anchors.fill: parent
                anchors.leftMargin: 8
                anchors.rightMargin: 8

                Row {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 3

                    Repeater {
                        model: 9

                        Rectangle {
                            required property int index
                            readonly property int workspaceId: index + 1
                            readonly property var workspace: Hyprland.workspaces.values.find(candidate => candidate.id === workspaceId)
                            readonly property bool onThisMonitor: workspace?.monitor?.name === barWindow.screen.name
                            readonly property bool active: onThisMonitor && workspace.active
                            readonly property bool occupied: onThisMonitor && workspace.toplevels.values.length > 0

                            visible: workspaceId <= 5 || onThisMonitor
                            width: 30
                            height: 35
                            color: "transparent"
                            opacity: active || occupied ? 1 : 0.5

                            Text {
                                anchors.centerIn: parent
                                text: parent.active ? "" : parent.workspaceId
                                color: parent.active ? "#c7a9ff" : "#a9b1d6"
                                font.family: "SF Compact Display, IosevkaTerm Nerd Font Propo"
                                font.pixelSize: 14
                                font.bold: true
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: Hyprland.dispatch("workspace " + parent.workspaceId)
                            }
                        }
                    }
                }

                SystemClock {
                    id: clock
                    precision: SystemClock.Minutes
                }

                Text {
                    anchors.centerIn: parent
                    text: Qt.formatDateTime(clock.date, "HH:mm")
                    color: "#a9b1d6"
                    font.family: "SF Compact Display, IosevkaTerm Nerd Font Propo"
                    font.pixelSize: 14
                    font.bold: true
                }

                Row {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    layoutDirection: Qt.RightToLeft

                    StatusIcon {
                        icon: barRoot.doNotDisturb ? "󰂛" : "󰂚"
                        tooltipText: barRoot.doNotDisturb ? "Do not disturb\n" + barRoot.notificationCount + " notifications" : barRoot.notificationCount + " notifications"
                        clicked: () => barRoot.toggleHistory()
                    }

                    StatusIcon {
                        id: batteryIcon

                        readonly property var battery: UPower.displayDevice
                        readonly property int percentage: battery ? Math.round(battery.percentage * 100) : 0
                        readonly property double remainingSeconds: UPower.onBattery ? battery?.timeToEmpty ?? 0 : battery?.timeToFull ?? 0
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
                        tooltipText: barRoot.batteryPower.toFixed(1) + "W" + (UPower.onBattery ? "↓ " : "↑ ") + percentage + "%"
                        clicked: () => batteryPopup.visible = !batteryPopup.visible

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
                            implicitWidth: 300
                            implicitHeight: 190

                            anchor {
                                item: batteryIcon
                                edges: Edges.Bottom
                                gravity: Edges.Bottom
                            }

                            Rectangle {
                                anchors.fill: parent
                                color: "#1a1b26"
                                border.color: "#c7a9ff"
                                border.width: 2
                                radius: 5

                                Column {
                                    anchors.fill: parent
                                    anchors.margins: 16
                                    spacing: 12

                                    Row {
                                        width: parent.width

                                        Text {
                                            width: parent.width / 2
                                            text: batteryIcon.percentage + "%"
                                            color: "#c0caf5"
                                            font.family: "SF Compact Display"
                                            font.pixelSize: 24
                                            font.bold: true
                                        }

                                        Text {
                                            width: parent.width / 2
                                            horizontalAlignment: Text.AlignRight
                                            text: barRoot.batteryPower.toFixed(1) + " W"
                                            color: "#a9b1d6"
                                            font.family: "SF Compact Display"
                                            font.pixelSize: 16
                                            font.bold: true
                                        }
                                    }

                                    Text {
                                        text: (UPower.onBattery ? "Remaining: " : "Until full: ") + batteryIcon.remainingText
                                        color: "#a9b1d6"
                                        font.family: "SF Compact Display"
                                        font.pixelSize: 13
                                    }

                                    Rectangle {
                                        width: parent.width
                                        height: 8
                                        color: "#414868"
                                        radius: 4

                                        Rectangle {
                                            width: parent.width * batteryIcon.percentage / 100
                                            height: parent.height
                                            color: "#c7a9ff"
                                            radius: 4
                                        }
                                    }

                                    Text {
                                        text: "Power profile"
                                        color: "#c0caf5"
                                        font.family: "SF Compact Display"
                                        font.pixelSize: 13
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

                                            Rectangle {
                                                required property var modelData
                                                readonly property bool selected: PowerProfiles.profile === modelData.profile

                                                visible: modelData.profile !== PowerProfile.Performance || PowerProfiles.hasPerformanceProfile
                                                width: 82
                                                height: 32
                                                color: selected ? "#c7a9ff" : "#414868"
                                                radius: 4

                                                Text {
                                                    anchors.centerIn: parent
                                                    text: parent.modelData.label
                                                    color: parent.selected ? "#1a1b26" : "#a9b1d6"
                                                    font.family: "SF Compact Display"
                                                    font.pixelSize: 12
                                                    font.bold: true
                                                }

                                                MouseArea {
                                                    anchors.fill: parent
                                                    cursorShape: Qt.PointingHandCursor
                                                    onClicked: PowerProfiles.profile = parent.modelData.profile
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    StatusIcon {
                        icon: barRoot.networkIcon
                        tooltipText: barRoot.networkTooltip
                        command: ["ghostty", "--class=dev.tombell.impala", "-e", "impala"]
                    }

                    StatusIcon {
                        icon: Bluetooth.defaultAdapter?.enabled ? "" : "󰂲"
                        tooltipText: Bluetooth.defaultAdapter?.enabled ? "Devices connected: " + Bluetooth.devices.values.filter(device => device.connected).length : "Bluetooth disabled"
                        command: ["ghostty", "--class=dev.tombell.bluetui", "-e", "bluetui"]
                    }

                    StatusIcon {
                        readonly property real volume: barRoot.audioSink?.audio?.volume ?? 0
                        readonly property bool muted: barRoot.audioSink?.audio?.muted ?? false
                        icon: muted ? "" : volume < 0.34 ? "" : volume < 0.67 ? "" : ""
                        readonly property real sourceVolume: barRoot.audioSource?.audio?.volume ?? 0
                        readonly property bool sourceMuted: barRoot.audioSource?.audio?.muted ?? false
                        tooltipText: (muted ? "Speaker muted" : "Speaker " + Math.round(volume * 100) + "%")
                            + "\n"
                            + (sourceMuted ? "Microphone muted" : "Microphone " + Math.round(sourceVolume * 100) + "%")
                        command: ["ghostty", "--class=dev.tombell.wiremix", "-e", "wiremix"]
                    }
                }
            }
        }
    }
}
