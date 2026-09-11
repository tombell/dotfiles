import Quickshell

import qs.Services

StatusIcon {
    readonly property real volume: Audio.sink?.audio?.volume ?? 0
    readonly property bool muted: Audio.sink?.audio?.muted ?? false
    readonly property real sourceVolume: Audio.source?.audio?.volume ?? 0
    readonly property bool sourceMuted: Audio.source?.audio?.muted ?? false

    icon: muted ? "" : volume < 0.34 ? "" : volume < 0.67 ? "" : ""
    tooltipText: (muted ? "Speaker muted" : "Speaker " + Math.round(volume * 100) + "%")
        + "\n"
        + (sourceMuted ? "Microphone muted" : "Microphone " + Math.round(sourceVolume * 100) + "%")
    onClicked: Quickshell.execDetached(["ghostty", "--class=dev.tombell.wiremix", "-e", "wiremix"])
}
