// ~/.config/quickshell/niri/bar/bar.qml
import QtQuick
import Quickshell
import Quickshell.Services.SystemTray

PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 32
    color: "#282C34"

    Row {
        anchors.fill: parent
        anchors.margins: 4
        spacing: 10

        Text {
            id: timeText
            font.pixelSize: 14
            color: "#ABB2BF"
            anchors.verticalCenter: parent.verticalCenter
            Component.onCompleted: {
                Qt.timer(1000, function () {
                    const d = new Date();
                    timeText.text = d.toLocaleTimeString();
                });
            }
        }

        Item {
            Layout.fillWidth: true
        } // push right

        SystemTray {
            id: tray
        }
    }
}
