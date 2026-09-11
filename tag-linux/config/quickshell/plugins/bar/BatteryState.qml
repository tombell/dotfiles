import QtQuick
import Quickshell
import Quickshell.Io

Scope {
    id: batteryState

    property real power: 0

    Process {
        id: batteryStatus
        command: ["sh", "-c", "battery=$(find /sys/class/power_supply -maxdepth 1 -name 'BAT*' | head -1); if [ -r \"$battery/power_now\" ]; then awk '{print $1 / 1000000}' \"$battery/power_now\"; elif [ -r \"$battery/current_now\" ] && [ -r \"$battery/voltage_now\" ]; then awk 'NR==FNR {current=$1; next} {print current * $1 / 1000000000000}' \"$battery/current_now\" \"$battery/voltage_now\"; else echo 0; fi"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: batteryState.power = Number(text.trim()) || 0
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: batteryStatus.running = true
    }
}
