import Quickshell
import Quickshell.Widgets

IconImage {
    required property string icon
    property var imageSource: ""

    source: imageSource || resolveIcon(icon)

    function resolveIcon(icon) {
        if (icon === "network-wired")
            return "file:///usr/share/icons/Adwaita/symbolic/devices/network-wired-symbolic.svg"
        if (icon && (icon.startsWith("/") || Quickshell.hasThemeIcon(icon)))
            return Quickshell.iconPath(icon)
        return "file:///usr/share/icons/Adwaita/scalable/mimetypes/application-x-executable.svg"
    }
}
