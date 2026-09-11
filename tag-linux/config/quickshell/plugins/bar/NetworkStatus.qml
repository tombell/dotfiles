import Quickshell

StatusIcon {
    required property NetworkState network

    icon: network.icon
    tooltipText: network.tooltipText
    onClicked: Quickshell.execDetached(["ghostty", "--class=dev.tombell.impala", "-e", "impala"])
}
