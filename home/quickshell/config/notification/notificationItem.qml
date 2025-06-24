import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.NotificationServer
import Quickshell.Wayland

Item {
    id: root
    width: 300
    height: content.implicitHeight + 20
    property alias notification: server.notifications[0]

    NotificationServer {
        id: server
    }

    Rectangle {
        id: content
        width: parent.width
        radius: 8
        color: "#3b4252"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.margins: 10

        ColumnLayout {
            id: layout
            anchors.fill: parent
            anchors.margins: 10
            spacing: 6

            RowLayout {
                spacing: 8
                Image {
                    id: iconImage
                    width: 24
                    height: 24
                    source: notification.icon // icon name or path
                }
                Label {
                    text: notification.appName
                    font.bold: true
                    color: "#ECEFF4"
                }
            }

            Label {
                text: notification.summary
                color: "#D8DEE9"
                wrapMode: Text.Wrap
            }

            Label {
                text: notification.body
                color: "#D8DEE9"
                wrapMode: Text.Wrap
                visible: notification.body !== ""
            }

            RowLayout {
                id: actionsRow
                spacing: 10
                Repeater {
                    model: notification.actions
                    Button {
                        text: modelData.text
                        onClicked: modelData.invoke()
                        background: Rectangle {
                            color: "#81A1C1"
                            radius: 4
                        }
                        font.pixelSize: 12
                    }
                }
            }
        }
    }

    // 自动关闭计时器
    Timer {
        interval: 5000
        running: true
        repeat: false
        onTriggered: server.closeNotification(notification)
    }

    // 飞入动画
    Behavior on x {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }
    Behavior on opacity {
        NumberAnimation {
            duration: 200
        }
    }

    Component.onCompleted: {
        x = root.parent.width;
        opacity = 0;
        x = root.parent.width - width - 20;
        opacity = 1;
    }
}
