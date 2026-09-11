import QtQuick
import Quickshell
import Quickshell.Io

Scope {
    id: networkState

    property string icon: "󰖪"
    property string tooltipText: "Disconnected"
    property double previousRxBytes: 0
    property double previousTxBytes: 0

    function formatRate(bytesPerSecond) {
        if (bytesPerSecond >= 1073741824) return (bytesPerSecond / 1073741824).toFixed(1) + " GiB/s"
        if (bytesPerSecond >= 1048576) return (bytesPerSecond / 1048576).toFixed(1) + " MiB/s"
        if (bytesPerSecond >= 1024) return (bytesPerSecond / 1024).toFixed(1) + " KiB/s"
        return Math.round(bytesPerSecond) + " B/s"
    }

    Process {
        id: networkStatus
        command: ["sh", "-c", "iface=$(ip route show default | awk 'NR==1 {print $5}'); if [ -z \"$iface\" ]; then echo 'disconnected'; else rx=$(cat /sys/class/net/$iface/statistics/rx_bytes); tx=$(cat /sys/class/net/$iface/statistics/tx_bytes); if [ -d /sys/class/net/$iface/wireless ]; then quality=$(awk 'NR==3 {print int($3)}' /proc/net/wireless); info=$(iwctl station \"$iface\" show 2>/dev/null | sed 's/\\x1b\\[[0-9;]*m//g'); ssid=$(printf '%s\\n' \"$info\" | awk '/Connected network/ {$1=$2=\"\"; sub(/^  */,\"\"); print; exit}'); freq=$(printf '%s\\n' \"$info\" | awk '/Frequency/ {print $2; exit}'); printf 'wifi|%s|%s|%s|%s|%s\\n' \"$quality\" \"$ssid\" \"$freq\" \"$rx\" \"$tx\"; else printf 'ethernet|%s|%s\\n' \"$rx\" \"$tx\"; fi; fi"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const status = text.trim()
                if (status === "disconnected" || status === "") {
                    networkState.icon = "󰖪"
                    networkState.tooltipText = "Disconnected"
                } else {
                    const fields = status.split("|")
                    const wifi = fields[0] === "wifi"
                    const rx = Number(fields[wifi ? 4 : 1])
                    const tx = Number(fields[wifi ? 5 : 2])
                    const down = networkState.previousRxBytes > 0 ? Math.max(0, rx - networkState.previousRxBytes) / 5 : 0
                    const up = networkState.previousTxBytes > 0 ? Math.max(0, tx - networkState.previousTxBytes) / 5 : 0
                    networkState.previousRxBytes = rx
                    networkState.previousTxBytes = tx

                    if (wifi) {
                        const quality = Number(fields[1])
                        const frequency = Number(fields[3]) / 1000
                        networkState.icon = quality < 20 ? "󰤯" : quality < 40 ? "󰤟" : quality < 55 ? "󰤢" : quality < 70 ? "󰤥" : "󰤨"
                        networkState.tooltipText = fields[2] + (frequency ? " (" + frequency.toFixed(2) + " GHz)" : "")
                    } else {
                        networkState.icon = "󰀂"
                        networkState.tooltipText = "Ethernet"
                    }
                    networkState.tooltipText += "\n⇣ " + networkState.formatRate(down) + " ⇡ " + networkState.formatRate(up)
                }
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: networkStatus.running = true
    }
}
