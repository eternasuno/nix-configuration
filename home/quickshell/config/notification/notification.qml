import QtQuick
import Quickshell
import Quickshell.Services.NotificationServer

Scope {
    id: root

    NotificationServer {
        id: server
        onNotificationAdded: {
            loader.source = "notificationItem.qml";
        }
    }

    Loader {
        id: loader
    }
}
