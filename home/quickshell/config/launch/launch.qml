import QtQuick
import QtQuick.Controls

FloatingWindow {
    anchors.centerIn: parent
    width: 600
    height: 400
    visible: false
    border.color: "#555"
    radius: 8
    color: "#2E3440"

    property bool active: false
    Keys.onShortcutActivated: {
        if (shortcut === "Escape")
            active = false;
    }

    Column {
        anchors.margins: 20
        spacing: 10

        TextField {
            id: search
            placeholderText: "Search apps..."
            font.pixelSize: 16
            onTextChanged: appList.model = apps.filter(name => name.indexOf(search.text) !== -1)
        }

        ListView {
            id: appList
            anchors.fill: parent
            model: apps
            delegate: Item {
                width: parent.width
                height: 48
                Text {
                    text: modelData.name
                    color: "#ECEFF4"
                    anchors.verticalCenter: parent.verticalCenter
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: Qt.processStart(modelData.exec)
                }
            }
        }
    }

    property var apps: [
        {
            name: "Firefox",
            exec: "firefox"
        },
        {
            name: "Terminal",
            exec: "alacritty"
        }
        // 更多 .desktop 数据
        ,
    ]
}
