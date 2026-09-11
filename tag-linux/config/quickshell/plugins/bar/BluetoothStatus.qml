import Quickshell
import Quickshell.Bluetooth

StatusIcon {
    icon: Bluetooth.defaultAdapter?.enabled ? "" : "󰂲"
    tooltipText: Bluetooth.defaultAdapter?.enabled ? "Devices connected: " + Bluetooth.devices.values.filter(device => device.connected).length : "Bluetooth disabled"
    onClicked: Quickshell.execDetached(["ghostty", "--class=dev.tombell.bluetui", "-e", "bluetui"])
}
