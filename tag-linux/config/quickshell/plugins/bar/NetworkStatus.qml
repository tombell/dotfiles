import QtQuick

StatusIcon {
    required property NetworkState network

    icon: network.icon
    tooltipText: network.tooltipText
    command: ["ghostty", "--class=dev.tombell.impala", "-e", "impala"]
}
