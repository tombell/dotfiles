import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import qs.Commons
import qs.Ui

Scope {
    IpcHandler {
        target: "launcher"

        function toggle(): void {
            launcher.visible = !launcher.visible
            if (launcher.visible) {
                launcherSearch.text = ""
                launcherState.updateApplications()
                launcherSearch.focusInput()
            }
        }
    }

    LauncherState {
        id: launcherState

        query: launcherSearch.text
        onLaunchRequested: command => {
            launcher.visible = false
            Quickshell.execDetached(command)
        }
    }

    PanelWindow {
        id: launcher

        visible: false
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        WlrLayershell.namespace: "quickshell-launcher"
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

        MouseArea {
            anchors.fill: parent
            onClicked: launcher.visible = false
        }

        PanelSurface {
            anchors.centerIn: parent
            width: Math.max(420, launcher.width * 0.3)
            height: 344

            MouseArea {
                anchors.fill: parent
                onClicked: mouse.accepted = true
            }

            Column {
                anchors.fill: parent
                anchors.margins: 2

                SearchField {
                    id: launcherSearch

                    width: parent.width
                    onDismissRequested: launcher.visible = false
                    onPreviousRequested: launcherState.selectPrevious()
                    onNextRequested: launcherState.selectNext()
                    onLaunchRequested: launcherState.launchSelectedApplication()
                }

                Rectangle {
                    width: parent.width
                    height: 2
                    color: Color.accent
                }

                ApplicationList {
                    width: parent.width
                    applications: launcherState.visibleApplications
                    selectedIndex: launcherState.selectedApplication
                    onSelectionRequested: index => launcherState.selectedApplication = index
                    onLaunchRequested: launcherState.launchSelectedApplication()
                }
            }
        }
    }
}
