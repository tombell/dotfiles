import QtQuick

StatusIcon {
    id: notifications

    required property bool doNotDisturb
    required property int notificationCount

    signal toggleHistory()

    icon: notifications.doNotDisturb ? "󰂛" : "󰂚"
    tooltipText: notifications.doNotDisturb ? "Do not disturb\n" + notifications.notificationCount + " notifications" : notifications.notificationCount + " notifications"
    onClicked: notifications.toggleHistory()
}
