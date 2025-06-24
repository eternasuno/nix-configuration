import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
    id: root
    property bool shouldShow: false

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio
        function onVolumeChanged() {
            root.shouldShow = true;
            hideTimer.restart();
        }
    }

    Timer {
        id: hideTimer
        interval: 1000
        repeat: false
        onTriggered: root.shouldShow = false
    }

    LazyLoader {
        active: root.shouldShow
        PanelWindow {
            anchors.bottom: true
            margins.bottom: screen.height / 5
            implicitWidth: 300
            implicitHeight: 40
            mask: Region {}
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: "#80000000"
                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 10
                    IconImage {
                        source: Quickshell.iconPath("audio-volume-high-symbolic")
                        implicitSize: 24
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 10
                        radius: 5
                        color: "#50FFFFFF"
                        Rectangle {
                            anchors.left: parent.left
                            anchors.fillVertical: true
                            implicitWidth: parent.width * (Pipewire.defaultAudioSink.audio.volume || 0)
                        }
                    }
                }
            }
        }
    }
}
