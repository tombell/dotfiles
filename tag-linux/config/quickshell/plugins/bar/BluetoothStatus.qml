import QtQuick
import Quickshell.Bluetooth

StatusIcon {
    icon: Bluetooth.defaultAdapter?.enabled ? "" : "󰂲"
    tooltipText: Bluetooth.defaultAdapter?.enabled ? "Devices connected: " + Bluetooth.devices.values.filter(device => device.connected).length : "Bluetooth disabled"
    command: ["ghostty", "--class=dev.tombell.bluetui", "-e", "bluetui"]
}
