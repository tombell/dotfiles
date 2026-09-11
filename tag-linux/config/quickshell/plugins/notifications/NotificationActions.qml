import QtQuick

import qs.Ui

Row {
    id: notificationActions

    required property var actions
    readonly property var visibleActions: actions.filter(action => action.identifier !== "default")

    spacing: 8
    visible: notificationActions.visibleActions.length > 0

    Repeater {
        model: notificationActions.visibleActions

        Button {
            required property var modelData

            text: modelData.text
            onClicked: modelData.invoke()
        }
    }
}
