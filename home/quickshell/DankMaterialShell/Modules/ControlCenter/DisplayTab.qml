import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import qs.Common
import qs.Modules
import qs.Services
import qs.Widgets

ScrollView {
    id: displayTab

    property var brightnessDebounceTimer

    brightnessDebounceTimer: Timer {
        property int pendingValue: 0

        interval: BrightnessService.ddcAvailable ? 500 : 50 // 500ms for slow DDC (i2c), 50ms for fast laptop backlight
        repeat: false
        onTriggered: {
            
            BrightnessService.setBrightness(pendingValue);
        }
    }

    clip: true
    Column {
        width: parent.width
        spacing: Theme.spacingL

        Column {
            width: parent.width
            spacing: Theme.spacingM
            visible: BrightnessService.brightnessAvailable

            StyledText {
                text: "Brightness"
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.surfaceText
                font.weight: Font.Medium
            }

            DankSlider {
                width: parent.width
                value: BrightnessService.brightnessLevel
                leftIcon: "brightness_low"
                rightIcon: "brightness_high"
                enabled: BrightnessService.brightnessAvailable
                onSliderValueChanged: function(newValue) {
                    
                    brightnessDebounceTimer.pendingValue = newValue;
                    brightnessDebounceTimer.restart();
                }
                onSliderDragFinished: function(finalValue) {
                    
                    brightnessDebounceTimer.stop();
                    BrightnessService.setBrightness(finalValue);
                }
            }

            StyledText {
                text: "using ddc - changes may take a moment to apply"
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.surfaceVariantText
                visible: BrightnessService.ddcAvailable && !BrightnessService.laptopBacklightAvailable
                anchors.horizontalCenter: parent.horizontalCenter
            }

        }

        Column {
            width: parent.width
            spacing: Theme.spacingM

            StyledText {
                text: "Display Settings"
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.surfaceText
                font.weight: Font.Medium
            }

            Row {
                width: parent.width
                spacing: Theme.spacingM

                Rectangle {
                    width: (parent.width - Theme.spacingM) / 2
                    height: 80
                    radius: Theme.cornerRadius
                    color: Prefs.nightModeEnabled ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.12) : (nightModeToggle.containsMouse ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.08) : Qt.rgba(Theme.surfaceVariant.r, Theme.surfaceVariant.g, Theme.surfaceVariant.b, 0.08))
                    border.color: Prefs.nightModeEnabled ? Theme.primary : "transparent"
                    border.width: Prefs.nightModeEnabled ? 1 : 0

                    Column {
                        anchors.centerIn: parent
                        spacing: Theme.spacingS

                        DankIcon {
                            name: Prefs.nightModeEnabled ? "nightlight" : "dark_mode"
                            size: Theme.iconSizeLarge
                            color: Prefs.nightModeEnabled ? Theme.primary : Theme.surfaceText
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        StyledText {
                            text: "Night Mode"
                            font.pixelSize: Theme.fontSizeMedium
                            color: Prefs.nightModeEnabled ? Theme.primary : Theme.surfaceText
                            font.weight: Font.Medium
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                    }

                    MouseArea {
                        id: nightModeToggle

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (Prefs.nightModeEnabled) {
                                nightModeDisableProcess.running = true;
                                Prefs.setNightModeEnabled(false);
                            } else {
                                nightModeEnableProcess.running = true;
                                Prefs.setNightModeEnabled(true);
                            }
                        }
                    }

                }

                Rectangle {
                    width: (parent.width - Theme.spacingM) / 2
                    height: 80
                    radius: Theme.cornerRadius
                    color: Theme.isLightMode ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.12) : (lightModeToggle.containsMouse ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.08) : Qt.rgba(Theme.surfaceVariant.r, Theme.surfaceVariant.g, Theme.surfaceVariant.b, 0.08))
                    border.color: Theme.isLightMode ? Theme.primary : "transparent"
                    border.width: Theme.isLightMode ? 1 : 0

                    Column {
                        anchors.centerIn: parent
                        spacing: Theme.spacingS

                        DankIcon {
                            name: Theme.isLightMode ? "light_mode" : "palette"
                            size: Theme.iconSizeLarge
                            color: Theme.isLightMode ? Theme.primary : Theme.surfaceText
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        StyledText {
                            text: Theme.isLightMode ? "Light Mode" : "Dark Mode"
                            font.pixelSize: Theme.fontSizeMedium
                            color: Theme.isLightMode ? Theme.primary : Theme.surfaceText
                            font.weight: Font.Medium
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                    }

                    MouseArea {
                        id: lightModeToggle

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Theme.toggleLightMode();
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: Theme.shortDuration
                            easing.type: Theme.standardEasing
                        }

                    }

                }

            }

        }

    }

    Process {
        id: nightModeEnableProcess

        command: ["bash", "-c", "if command -v wlsunset > /dev/null; then pkill wlsunset; wlsunset -t 3000 & elif command -v redshift > /dev/null; then pkill redshift; redshift -P -O 3000 & else echo 'No night mode tool available'; fi"]
        running: false
        onExited: (exitCode) => {
            if (exitCode !== 0) {
                
                Prefs.setNightModeEnabled(false);
            }
        }
    }

    Process {
        id: nightModeDisableProcess

        command: ["bash", "-c", "pkill wlsunset; pkill redshift; if command -v wlsunset > /dev/null; then wlsunset -t 6500 -T 6500 & sleep 1; pkill wlsunset; elif command -v redshift > /dev/null; then redshift -P -O 6500; redshift -x; fi"]
        running: false
        onExited: (exitCode) => {
            if (exitCode !== 0)
                

        }
    }

}
