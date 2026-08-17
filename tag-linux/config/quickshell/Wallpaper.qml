import QtQuick
import Quickshell
import Quickshell.Wayland

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData
            color: "black"
            exclusionMode: ExclusionMode.Ignore
            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            WlrLayershell.layer: WlrLayer.Background
            WlrLayershell.namespace: "quickshell-wallpaper"

            Image {
                anchors.fill: parent
                source: "file://" + Quickshell.env("HOME") + "/Pictures/Wallpaper/wallpaper.jpg"
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                cache: true
            }
        }
    }
}
