import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

import qs.Commons
import qs.Ui
Scope {
    id: launcherRoot

    IpcHandler {
        target: "launcher"

        function toggle(): void {
            launcher.visible = !launcher.visible
            if (launcher.visible) {
                launcherSearch.text = ""
                launcherRoot.updateApplications()
                launcherSearch.forceActiveFocus()
            }
        }
    }

    property var filteredApplications: []
    property int selectedApplication: 0

    function updateApplications() {
        const query = launcherSearch.text.toLowerCase().trim()
        filteredApplications = DesktopEntries.applications.values
            .filter(entry => !entry.noDisplay && (query === ""
                || entry.name.toLowerCase().includes(query)
                || entry.genericName.toLowerCase().includes(query)
                || entry.comment.toLowerCase().includes(query)))
            .sort((a, b) => {
                const aName = a.name.toLowerCase()
                const bName = b.name.toLowerCase()
                if (query !== "" && aName.startsWith(query) !== bName.startsWith(query))
                    return aName.startsWith(query) ? -1 : 1
                return aName.localeCompare(bName)
            })
        selectedApplication = 0
    }

    function applicationIcon(icon) {
        if (icon === "network-wired")
            return "file:///usr/share/icons/Adwaita/symbolic/devices/network-wired-symbolic.svg"
        if (icon && (icon.startsWith("/") || Quickshell.hasThemeIcon(icon)))
            return Quickshell.iconPath(icon)
        return "file:///usr/share/icons/Adwaita/scalable/mimetypes/application-x-executable.svg"
    }

    function launchSelectedApplication() {
        const entry = filteredApplications[selectedApplication]
        if (!entry) return
        launcher.visible = false
        const command = entry.runInTerminal
            ? ["uwsm", "app", "--", "ghostty", "-e"].concat(entry.command)
            : ["uwsm", "app", "--"].concat(entry.command)
        Quickshell.execDetached(command)
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

                Rectangle {
                    width: parent.width
                    height: 54
                    color: Color.surface

                    Label {
                        anchors.left: parent.left
                        anchors.leftMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Apps"
                        color: Color.accent
                        font.pixelSize: 14
                        font.bold: true
                    }

                    TextInput {
                        id: launcherSearch

                        anchors.left: parent.left
                        anchors.leftMargin: 58
                        anchors.right: parent.right
                        anchors.rightMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        color: Color.foregroundStrong
                        selectionColor: Color.subdued
                        font.pixelSize: 14
                        font.bold: true
                        clip: true
                        onTextChanged: launcherRoot.updateApplications()
                        Keys.onEscapePressed: launcher.visible = false
                        Keys.onUpPressed: launcherRoot.selectedApplication = Math.max(0, launcherRoot.selectedApplication - 1)
                        Keys.onDownPressed: launcherRoot.selectedApplication = Math.min(Math.min(4, launcherRoot.filteredApplications.length - 1), launcherRoot.selectedApplication + 1)
                        Keys.onReturnPressed: launcherRoot.launchSelectedApplication()
                        Keys.onEnterPressed: launcherRoot.launchSelectedApplication()
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 2
                    color: Color.accent
                }

                Repeater {
                    model: Math.min(5, launcherRoot.filteredApplications.length)

                    Rectangle {
                        required property int index
                        readonly property var entry: launcherRoot.filteredApplications[index]

                        width: parent.width
                        height: 56.8
                        color: index === launcherRoot.selectedApplication ? Color.subdued : "transparent"

                        IconImage {
                            anchors.left: parent.left
                            anchors.leftMargin: 12
                            anchors.verticalCenter: parent.verticalCenter
                            width: 28
                            height: 28
                            source: launcherRoot.applicationIcon(parent.entry.icon)
                        }

                        Label {
                            anchors.left: parent.left
                            anchors.leftMargin: 52
                            anchors.right: parent.right
                            anchors.rightMargin: 12
                            anchors.verticalCenter: parent.verticalCenter
                            text: parent.entry.name
                            color: parent.index === launcherRoot.selectedApplication ? Color.foregroundStrong : Color.foreground
                            elide: Text.ElideRight
                            font.pixelSize: 14
                            font.bold: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: launcherRoot.selectedApplication = parent.index
                            onClicked: launcherRoot.launchSelectedApplication()
                        }
                    }
                }
            }
        }
    }

}
