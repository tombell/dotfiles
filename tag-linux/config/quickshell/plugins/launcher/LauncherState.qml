import Quickshell

Scope {
    id: launcherState

    property string query: ""
    property var filteredApplications: []
    property int selectedIndex: 0
    readonly property var visibleApplications: filteredApplications.slice(0, 5)

    signal launchRequested(var command)

    onQueryChanged: updateApplications()

    function updateApplications() {
        const query = launcherState.query.toLowerCase().trim()
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
        selectedIndex = 0
    }

    function selectPrevious() {
        selectedIndex = Math.max(0, selectedIndex - 1)
    }

    function selectNext() {
        selectedIndex = Math.max(0, Math.min(visibleApplications.length - 1, selectedIndex + 1))
    }

    function launchApplication(index) {
        const entry = visibleApplications[index]
        if (!entry) return
        const command = entry.runInTerminal
            ? ["uwsm", "app", "--", "ghostty", "-e"].concat(entry.command)
            : ["uwsm", "app", "--"].concat(entry.command)
        launchRequested(command)
    }
}
