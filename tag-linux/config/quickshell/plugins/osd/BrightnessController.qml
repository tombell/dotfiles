import Quickshell
import Quickshell.Io

Scope {
    id: brightnessController

    property string device: ""
    property string icon: "󰃠"

    signal showRequested(string icon, real value, bool muted)

    Process {
        id: brightnessOsdCommand

        stdout: StdioCollector {
            onStreamFinished: {
                const fields = text.trim().split(",")
                if (fields.length < 4) return
                const percentage = Number(fields[3].replace("%", ""))
                if (!Number.isFinite(percentage)) return
                const value = Math.max(0, Math.min(1, percentage / 100))
                brightnessController.showRequested(brightnessController.icon, value, false)
            }
        }
    }

    function adjustBrightness(amount) {
        const command = ["brightnessctl", "-m"]
        if (device !== "") command.push("--device=" + device)
        command.push("set", amount)
        brightnessOsdCommand.command = command
        brightnessOsdCommand.running = true
    }

    function brightnessLower() {
        adjustBrightness("5%-")
    }

    function brightnessRaise() {
        adjustBrightness("+5%")
    }
}
