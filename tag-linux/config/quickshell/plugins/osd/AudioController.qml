import Quickshell

import qs.Services

Scope {
    id: audioController

    signal showRequested(string icon, real value, bool muted)

    function showOutputOsd() {
        const value = Math.min(1, Audio.sink?.audio?.volume ?? 0)
        const muted = Audio.sink?.audio?.muted ?? false
        const icon = muted ? "" : value < 0.34 ? "" : value < 0.67 ? "" : ""
        showRequested(icon, value, muted)
    }

    function showInputOsd() {
        const value = Math.min(1, Audio.source?.audio?.volume ?? 0)
        const muted = Audio.source?.audio?.muted ?? false
        const icon = muted ? "" : ""
        showRequested(icon, value, muted)
    }

    function outputMute() {
        if (!Audio.sink?.audio) return
        Audio.sink.audio.muted = !Audio.sink.audio.muted
        audioController.showOutputOsd()
    }

    function outputLower() {
        if (!Audio.sink?.audio) return
        Audio.sink.audio.volume = Math.max(0, Audio.sink.audio.volume - 0.05)
        audioController.showOutputOsd()
    }

    function outputRaise() {
        if (!Audio.sink?.audio) return
        Audio.sink.audio.volume = Math.min(1, Audio.sink.audio.volume + 0.05)
        audioController.showOutputOsd()
    }

    function inputMute() {
        if (!Audio.source?.audio) return
        Audio.source.audio.muted = !Audio.source.audio.muted
        audioController.showInputOsd()
    }
}
