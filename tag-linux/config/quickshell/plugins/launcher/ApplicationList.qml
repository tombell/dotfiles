import QtQuick

Column {
    id: applicationList

    required property var applications
    required property int selectedIndex

    signal selectionRequested(int index)
    signal launchRequested()

    Repeater {
        model: applicationList.applications.length

        ApplicationRow {
            required property int index

            entry: applicationList.applications[index]
            selected: index === applicationList.selectedIndex
            width: applicationList.width
            onHovered: applicationList.selectionRequested(index)
            onActivated: applicationList.launchRequested()
        }
    }
}
