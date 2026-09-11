import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.Commons

Scope {
    id: barRoot

    property bool doNotDisturb: false
    property int notificationCount: 0

    signal toggleHistory()

    // Share service instances across screens instead of creating one per window.
    BatteryState {
        id: batteryState
    }

    NetworkState {
        id: networkState
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow

            required property var modelData

            screen: modelData
            color: Color.background
            implicitHeight: Style.barHeight
            anchors {
                top: true
                left: true
                right: true
            }

            WlrLayershell.namespace: "quickshell-bar"

            Item {
                anchors.fill: parent
                anchors.leftMargin: 8
                anchors.rightMargin: 8

                Workspaces {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    monitorName: barWindow.screen.name
                }

                Clock {
                    anchors.centerIn: parent
                }

                Row {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    layoutDirection: Qt.RightToLeft

                    NotificationStatus {
                        doNotDisturb: barRoot.doNotDisturb
                        notificationCount: barRoot.notificationCount
                        onToggleHistory: barRoot.toggleHistory()
                    }

                    BatteryStatus {
                        power: batteryState.power
                    }

                    NetworkStatus {
                        network: networkState
                    }

                    BluetoothStatus {}

                    AudioStatus {}
                }
            }
        }
    }
}
