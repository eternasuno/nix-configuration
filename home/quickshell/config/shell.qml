import QtQuick
import Quickshell
import Quickshell.Services.Greetd
import Quickshell.Services.Pam
import Quickshell.Wayland

Shell {
  id: root
  width: Screen.width
  height: Screen.height

  property bool isLoginMode: Qt.application.arguments.indexOf("--login") !== -1
  property bool isLockMode: Qt.application.arguments.indexOf("--lock") !== -1

  Component.onCompleted: {
    if (isLoginMode) {
      loader.source = "greeter/login.qml"
    } else if (isLockMode) {
      loader.source = "lockscreen/lockscreen.qml"
    } else {
      loader.source = "bar/bar.qml"
      addComponent("launch/launch.qml")
      addComponent("osd/osd.qml")
      addComponent("notification/notification.qml")
    }
  }

  Loader { id: loader }

  function addComponent(path) {
    Loader { source: path }
  }
}
