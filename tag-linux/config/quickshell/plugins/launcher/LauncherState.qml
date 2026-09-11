import Quickshell

Scope {
    id: launcherState

    property string query: ""
    property var filteredApplications: []
    property int selectedApplication: 0
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
        selectedApplication = 0
    }

    function selectPrevious() {
        selectedApplication = Math.max(0, selectedApplication - 1)
    }

    function selectNext() {
        selectedApplication = Math.min(visibleApplications.length - 1, selectedApplication + 1)
    }

    function launchSelectedApplication() {
        const entry = filteredApplications[selectedApplication]
        if (!entry) return
        const command = entry.runInTerminal
            ? ["uwsm", "app", "--", "ghostty", "-e"].concat(entry.command)
            : ["uwsm", "app", "--"].concat(entry.command)
        launchRequested(command)
    }
}
