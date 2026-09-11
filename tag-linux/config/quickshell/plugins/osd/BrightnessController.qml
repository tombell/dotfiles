import Quickshell
import Quickshell.Io

Scope {
    id: brightnessController

    signal showRequested(string icon, real value, bool muted)

    Process {
        id: brightnessOsdCommand

        stdout: StdioCollector {
            onStreamFinished: {
                const value = Math.max(0, Math.min(1, Number(text.trim()) / 100))
                brightnessController.showRequested("󰃠", value, false)
            }
        }
    }

    function brightnessLower() {
        brightnessOsdCommand.command = ["sh", "-c", "brightnessctl set 5%- >/dev/null; brightnessctl -m | cut -d, -f4 | tr -d '%'"]
        brightnessOsdCommand.running = true
    }

    function brightnessRaise() {
        brightnessOsdCommand.command = ["sh", "-c", "brightnessctl set +5% >/dev/null; brightnessctl -m | cut -d, -f4 | tr -d '%'"]
        brightnessOsdCommand.running = true
    }
}
