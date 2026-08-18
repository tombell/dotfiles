import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Wayland

import qs.Commons
import qs.Ui
Scope {
    id: osdRoot

    readonly property var audioSink: Pipewire.defaultAudioSink
    readonly property var audioSource: Pipewire.defaultAudioSource

    PwObjectTracker {
        objects: [osdRoot.audioSink, osdRoot.audioSource].filter(object => object !== null)
    }

    property string osdIcon: ""
    property real osdValue: 0
    property bool osdMuted: false

    function showOsd() {
        osd.visible = true
        osdHide.restart()
    }

    function showOutputOsd() {
        osdValue = Math.min(1, audioSink?.audio?.volume ?? 0)
        osdMuted = audioSink?.audio?.muted ?? false
        osdIcon = osdMuted ? "" : osdValue < 0.34 ? "" : osdValue < 0.67 ? "" : ""
        showOsd()
    }

    function showInputOsd() {
        osdValue = Math.min(1, audioSource?.audio?.volume ?? 0)
        osdMuted = audioSource?.audio?.muted ?? false
        osdIcon = osdMuted ? "" : ""
        showOsd()
    }

    Process {
        id: audioOsdCommand

        stdout: StdioCollector {
            onStreamFinished: {
                const match = text.match(/Volume:\\s+([0-9.]+)/)
                osdRoot.osdValue = match ? Math.min(1, Number(match[1])) : 0
                osdRoot.osdMuted = text.includes("MUTED")
                osdRoot.osdIcon = osdRoot.osdMuted ? "" : osdRoot.osdValue < 0.34 ? "" : osdRoot.osdValue < 0.67 ? "" : ""
                osdRoot.showOsd()
            }
        }
    }

    Process {
        id: microphoneOsdCommand

        stdout: StdioCollector {
            onStreamFinished: {
                const match = text.match(/Volume:\\s+([0-9.]+)/)
                osdRoot.osdValue = match ? Math.min(1, Number(match[1])) : 0
                osdRoot.osdMuted = text.includes("MUTED")
                osdRoot.osdIcon = osdRoot.osdMuted ? "" : ""
                osdRoot.showOsd()
            }
        }
    }

    Process {
        id: brightnessOsdCommand

        stdout: StdioCollector {
            onStreamFinished: {
                osdRoot.osdValue = Math.max(0, Math.min(1, Number(text.trim()) / 100))
                osdRoot.osdMuted = false
                osdRoot.osdIcon = "󰃠"
                osdRoot.showOsd()
            }
        }
    }

    IpcHandler {
        target: "osd"

        function outputMute(): void {
            if (!osdRoot.audioSink?.audio) return
            osdRoot.audioSink.audio.muted = !osdRoot.audioSink.audio.muted
            osdRoot.showOutputOsd()
        }

        function outputLower(): void {
            if (!osdRoot.audioSink?.audio) return
            osdRoot.audioSink.audio.volume = Math.max(0, osdRoot.audioSink.audio.volume - 0.05)
            osdRoot.showOutputOsd()
        }

        function outputRaise(): void {
            if (!osdRoot.audioSink?.audio) return
            osdRoot.audioSink.audio.volume = Math.min(1, osdRoot.audioSink.audio.volume + 0.05)
            osdRoot.showOutputOsd()
        }

        function inputMute(): void {
            if (!osdRoot.audioSource?.audio) return
            osdRoot.audioSource.audio.muted = !osdRoot.audioSource.audio.muted
            osdRoot.showInputOsd()
        }

        function brightnessLower(): void {
            brightnessOsdCommand.command = ["sh", "-c", "brightnessctl set 5%- >/dev/null; brightnessctl -m | cut -d, -f4 | tr -d '%'"]
            brightnessOsdCommand.running = true
        }

        function brightnessRaise(): void {
            brightnessOsdCommand.command = ["sh", "-c", "brightnessctl set +5% >/dev/null; brightnessctl -m | cut -d, -f4 | tr -d '%'"]
            brightnessOsdCommand.running = true
        }
    }

    Timer {
        id: osdHide
        interval: 1500
        onTriggered: osd.visible = false
    }

    PanelWindow {
        id: osd

        visible: false
        color: "transparent"
        implicitWidth: 260
        implicitHeight: 58
        exclusionMode: ExclusionMode.Ignore
        anchors.bottom: true
        margins.bottom: 80

        WlrLayershell.namespace: "quickshell-osd"

        PanelSurface {
            anchors.fill: parent

            IconLabel {
                anchors.left: parent.left
                anchors.leftMargin: 18
                anchors.verticalCenter: parent.verticalCenter
                text: osdRoot.osdIcon
                color: osdRoot.osdMuted ? Color.urgent : Color.foreground
                font.pixelSize: 22
            }

            ProgressBar {
                anchors.left: parent.left
                anchors.leftMargin: 58
                anchors.right: parent.right
                anchors.rightMargin: 18
                anchors.verticalCenter: parent.verticalCenter
                height: 8
                value: osdRoot.osdValue
                fillColor: osdRoot.osdMuted ? Color.urgent : Color.accent
            }
        }
    }

}
