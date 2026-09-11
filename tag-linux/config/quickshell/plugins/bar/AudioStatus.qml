import QtQuick

StatusIcon {
    required property AudioState audio

    readonly property real volume: audio.sink?.audio?.volume ?? 0
    readonly property bool muted: audio.sink?.audio?.muted ?? false
    icon: muted ? "" : volume < 0.34 ? "" : volume < 0.67 ? "" : ""
    readonly property real sourceVolume: audio.source?.audio?.volume ?? 0
    readonly property bool sourceMuted: audio.source?.audio?.muted ?? false
    tooltipText: (muted ? "Speaker muted" : "Speaker " + Math.round(volume * 100) + "%")
        + "\n"
        + (sourceMuted ? "Microphone muted" : "Microphone " + Math.round(sourceVolume * 100) + "%")
    command: ["ghostty", "--class=dev.tombell.wiremix", "-e", "wiremix"]
}
