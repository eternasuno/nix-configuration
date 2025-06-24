import QtQuick
import QtQuick.Controls
import Quickshell.Services.Greetd

Greetd {
    id: greeter
    anchors.fill: parent

    // 背景
    Rectangle {
        anchors.fill: parent
        color: "#2e3440" // 深色背景
    }

    // 登录框
    Rectangle {
        width: 300
        height: 200
        anchors.centerIn: parent
        color: "#3b4252"
        radius: 10
        border.color: "#4c566a"
        border.width: 2

        Column {
            anchors.centerIn: parent
            spacing: 10

            TextField {
                id: usernameField
                width: parent.width * 0.8
                placeholderText: "用户名"
                focus: true
            }

            TextField {
                id: passwordField
                width: parent.width * 0.8
                placeholderText: "密码"
                echoMode: TextInput.Password
            }

            Button {
                text: "登录"
                width: parent.width * 0.8
                onClicked: {
                    // 调用 Greetd 服务进行身份验证
                    greeter.authenticate(usernameField.text, passwordField.text);
                }
            }
        }
    }
}
