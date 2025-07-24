import QtQuick
import Quickshell
import qs.Settings
import qs.Components
import qs.Bar.Modules

Item {
    id: volumeDisplay
    property var shell
    property int volume: 0

    // The total width will match the pill's width
    width: pillIndicator.width
    height: pillIndicator.height

    PillIndicator {
        id: pillIndicator
        icon: shell && shell.defaultAudioSink && shell.defaultAudioSink.audio && shell.defaultAudioSink.audio.muted ? "volume_off" : (volume === 0 ? "volume_off" : (volume < 30 ? "volume_down" : "volume_up"))
        text: volume + "%"

        pillColor: Theme.surfaceVariant
        iconCircleColor: Theme.accentPrimary
        iconTextColor: Theme.backgroundPrimary
        textColor: Theme.textPrimary
        StyledTooltip {
            id: volumeTooltip
            text: "Volume: " + volume + "%\nScroll up/down to change volume"
            tooltipVisible: !ioSelector.visible && volumeDisplay.containsMouse
            targetItem: pillIndicator
            delay: 200
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if (ioSelector.visible) {
                    ioSelector.dismiss();
                } else {
                    ioSelector.show();
                }
            }
        }
    }

    Connections {
        target: shell ?? null
        function onVolumeChanged() {
            if (shell && shell.volume !== volume) {
                volume = shell.volume
                pillIndicator.text = volume + "%"
                pillIndicator.icon = shell && shell.defaultAudioSink && shell.defaultAudioSink.audio && shell.defaultAudioSink.audio.muted ? "volume_off" : (volume === 0 ? "volume_off" : (volume < 30 ? "volume_down" : "volume_up"))
                pillIndicator.show()
            }
        }
    }

    Component.onCompleted: {
        if (shell && shell.volume !== undefined) {
            volume = shell.volume
            pillIndicator.show()
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton // Accept wheel events only
        propagateComposedEvents: true
        onEntered: volumeDisplay.containsMouse = true
        onExited: volumeDisplay.containsMouse = false
        cursorShape: Qt.PointingHandCursor
        onWheel:(wheel) => {
            if (!shell) return;
            let step = 5;
            if (wheel.angleDelta.y > 0) {
                shell.updateVolume(Math.min(100, shell.volume + step));
            } else if (wheel.angleDelta.y < 0) {
                shell.updateVolume(Math.max(0, shell.volume - step));
            }
        }
    }

    AudioDeviceSelector {
        id: ioSelector
        onPanelClosed: ioSelector.dismiss()
    }

    property bool containsMouse: false
}
