pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Scope {
    id: audioState

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property var source: Pipewire.defaultAudioSource

    PwObjectTracker {
        objects: [audioState.sink, audioState.source].filter(object => object !== null)
    }
}
