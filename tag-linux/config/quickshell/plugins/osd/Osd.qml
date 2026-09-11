import Quickshell
import Quickshell.Io

Scope {
    IpcHandler {
        target: "osd"

        function outputMute(): void { audioController.outputMute() }
        function outputLower(): void { audioController.outputLower() }
        function outputRaise(): void { audioController.outputRaise() }
        function inputMute(): void { audioController.inputMute() }
        function brightnessLower(): void { brightnessController.brightnessLower() }
        function brightnessRaise(): void { brightnessController.brightnessRaise() }
    }

    AudioController {
        id: audioController

        onShowRequested: (icon, value, muted) => osd.showOsd(icon, value, muted)
    }

    BrightnessController {
        id: brightnessController

        onShowRequested: (icon, value, muted) => osd.showOsd(icon, value, muted)
    }

    OsdWindow {
        id: osd
    }
}
