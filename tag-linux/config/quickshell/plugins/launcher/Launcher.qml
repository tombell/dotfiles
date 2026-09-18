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
            launcherLoader.active = !launcherLoader.active
        }
    }

    LazyLoader {
        id: launcherLoader

        active: false

        PanelWindow {
            id: launcher

            visible: true
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

            Component.onCompleted: {
                launcherState.updateApplications()
                launcherSearch.focusInput()
            }

            LauncherState {
                id: launcherState

                query: launcherSearch.text
                onLaunchRequested: command => {
                    Quickshell.execDetached(command)
                    launcherLoader.active = false
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: launcherLoader.active = false
            }

            PanelSurface {
                anchors.centerIn: parent
                width: Math.max(420, launcher.width * 0.3)
                height: 344

                MouseArea {
                    anchors.fill: parent
                    onClicked: mouse => mouse.accepted = true
                }

                Column {
                    anchors.fill: parent
                    anchors.margins: 2

                    SearchField {
                        id: launcherSearch

                        width: parent.width
                        onDismissRequested: launcherLoader.active = false
                        onPreviousRequested: launcherState.selectPrevious()
                        onNextRequested: launcherState.selectNext()
                        onLaunchRequested: launcherState.launchApplication(launcherState.selectedIndex)
                    }

                    Rectangle {
                        width: parent.width
                        height: 2
                        color: Color.accent
                    }

                    ApplicationList {
                        width: parent.width
                        applications: launcherState.visibleApplications
                        selectedIndex: launcherState.selectedIndex
                        onSelectionRequested: index => launcherState.selectedIndex = index
                        onLaunchRequested: index => launcherState.launchApplication(index)
                    }
                }
            }
        }
    }
}
