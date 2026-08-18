import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Scope {
    id: root

    property bool enabled: true
    property bool idleCycleActive: false
    property bool brightnessDimmed: false
    property bool displaysOff: false

    readonly property int dimTimeoutSeconds: 150
    readonly property int lockTimeoutSeconds: 300
    readonly property int displayOffTimeoutSeconds: 330
    readonly property int suspendTimeoutSeconds: 1800

    function run(process) {
        if (!process.running)
            process.running = true
    }

    function beginIdleCycle() {
        if (!root.enabled || root.idleCycleActive)
            return

        root.idleCycleActive = true
        root.brightnessDimmed = true
        root.run(dimProcess)
        lockTimer.restart()
        displayOffTimer.restart()
        suspendTimer.restart()
    }

    function endIdleCycle() {
        lockTimer.stop()
        displayOffTimer.stop()
        suspendTimer.stop()

        if (root.displaysOff)
            root.run(displayOnProcess)
        if (root.brightnessDimmed)
            root.run(brightnessRestoreProcess)

        root.displaysOff = false
        root.brightnessDimmed = false
        root.idleCycleActive = false
    }

    function setEnabled(value) {
        root.enabled = value
        if (!value)
            root.endIdleCycle()
        else if (idleMonitor.isIdle)
            root.beginIdleCycle()
    }

    IdleMonitor {
        id: idleMonitor
        enabled: root.enabled
        timeout: root.dimTimeoutSeconds
        respectInhibitors: true
        onIsIdleChanged: {
            if (isIdle)
                root.beginIdleCycle()
            else
                root.endIdleCycle()
        }
    }

    Timer {
        id: lockTimer
        interval: (root.lockTimeoutSeconds - root.dimTimeoutSeconds) * 1000
        onTriggered: root.run(lockProcess)
    }

    Timer {
        id: displayOffTimer
        interval: (root.displayOffTimeoutSeconds - root.dimTimeoutSeconds) * 1000
        onTriggered: {
            root.displaysOff = true
            root.run(displayOffProcess)
        }
    }

    Timer {
        id: suspendTimer
        interval: (root.suspendTimeoutSeconds - root.dimTimeoutSeconds) * 1000
        onTriggered: root.run(suspendProcess)
    }

    Process {
        id: dimProcess
        command: ["brightnessctl", "-e4", "-s", "set", "25%"]
    }

    Process {
        id: brightnessRestoreProcess
        command: ["brightnessctl", "-r"]
    }

    Process {
        id: lockProcess
        command: ["sh", "-c", "pidof hyprlock >/dev/null || exec hyprlock"]
    }

    Process {
        id: displayOffProcess
        command: ["hyprctl", "dispatch", "dpms", "off"]
    }

    Process {
        id: displayOnProcess
        command: ["hyprctl", "dispatch", "dpms", "on"]
    }

    Process {
        id: suspendProcess
        command: ["systemctl", "suspend"]
    }

    IpcHandler {
        target: "idle"

        function enable(): void { root.setEnabled(true) }
        function disable(): void { root.setEnabled(false) }
        function toggle(): void { root.setEnabled(!root.enabled) }
        function status(): string {
            return JSON.stringify({
                enabled: root.enabled,
                idle: idleMonitor.isIdle,
                idleCycleActive: root.idleCycleActive,
                brightnessDimmed: root.brightnessDimmed,
                displaysOff: root.displaysOff
            })
        }
    }
}
