import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Wayland
import Quickshell.Widgets
import qs.Common
import qs.Services
import qs.Widgets

PanelWindow {
    id: root

    property bool batteryPopupVisible: false

    function isActiveProfile(profile) {
        if (typeof PowerProfiles === "undefined")
            return false;

        return PowerProfiles.profile === profile;
    }

    function setProfile(profile) {
        if (typeof PowerProfiles === "undefined") {
            ToastService.showError("power-profiles-daemon not available");
            return ;
        }
        PowerProfiles.profile = profile;
        if (PowerProfiles.profile !== profile)
            ToastService.showError("Failed to set power profile");

    }

    visible: batteryPopupVisible
    implicitWidth: 400
    implicitHeight: 300
    WlrLayershell.layer: WlrLayershell.Overlay
    WlrLayershell.exclusiveZone: -1
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
    color: "transparent"

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    // Click outside to dismiss overlay
    MouseArea {
        anchors.fill: parent
        onClicked: function(mouse) {
            // Only close if click is outside the content loader
            var localPos = mapToItem(contentLoader, mouse.x, mouse.y);
            if (localPos.x < 0 || localPos.x > contentLoader.width || localPos.y < 0 || localPos.y > contentLoader.height)
                batteryPopupVisible = false;

        }
    }

    Loader {
        id: contentLoader

        readonly property real targetWidth: Math.min(380, Screen.width - Theme.spacingL * 2)
        readonly property real targetHeight: Math.min(450, Screen.height - Theme.barHeight - Theme.spacingS * 2)

        asynchronous: true
        active: batteryPopupVisible
        width: targetWidth
        height: targetHeight
        x: Math.max(Theme.spacingL, Screen.width - targetWidth - Theme.spacingL)
        y: Theme.barHeight + Theme.spacingS
        // GPU-accelerated scale + opacity animation
        opacity: batteryPopupVisible ? 1 : 0
        scale: batteryPopupVisible ? 1 : 0.9

        Behavior on opacity {
            NumberAnimation {
                duration: Anims.durMed
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Anims.emphasized
            }

        }

        Behavior on scale {
            NumberAnimation {
                duration: Anims.durMed
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Anims.emphasized
            }

        }

        sourceComponent: Rectangle {
            color: Theme.popupBackground()
            radius: Theme.cornerRadiusLarge
            border.color: Theme.outlineMedium
            border.width: 1
            // Remove layer rendering for better performance
            antialiasing: true
            smooth: true

            // Material 3 elevation with multiple layers
            Rectangle {
                anchors.fill: parent
                anchors.margins: -3
                color: "transparent"
                radius: parent.radius + 3
                border.color: Qt.rgba(0, 0, 0, 0.05)
                border.width: 1
                z: -3
            }

            Rectangle {
                anchors.fill: parent
                anchors.margins: -2
                color: "transparent"
                radius: parent.radius + 2
                border.color: Theme.shadowMedium
                border.width: 1
                z: -2
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border.color: Theme.outlineStrong
                border.width: 1
                radius: parent.radius
                z: -1
            }

            ScrollView {
                anchors.fill: parent
                anchors.margins: Theme.spacingL
                clip: true

                Column {
                    width: parent.width
                    spacing: Theme.spacingL

                    Row {
                        width: parent.width

                        StyledText {
                            text: BatteryService.batteryAvailable ? "Battery Information" : "Power Management"
                            font.pixelSize: Theme.fontSizeLarge
                            color: Theme.surfaceText
                            font.weight: Font.Medium
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Item {
                            width: parent.width - 200
                            height: 1
                        }

                        Rectangle {
                            width: 32
                            height: 32
                            radius: 16
                            color: closeBatteryArea.containsMouse ? Theme.errorHover : "transparent"

                            DankIcon {
                                anchors.centerIn: parent
                                name: "close"
                                size: Theme.iconSize - 4
                                color: closeBatteryArea.containsMouse ? Theme.error : Theme.surfaceText
                            }

                            MouseArea {
                                id: closeBatteryArea

                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    batteryPopupVisible = false;
                                }
                            }

                        }

                    }

                    Rectangle {
                        width: parent.width
                        height: 80
                        radius: Theme.cornerRadiusLarge
                        color: Qt.rgba(Theme.surfaceVariant.r, Theme.surfaceVariant.g, Theme.surfaceVariant.b, Theme.getContentBackgroundAlpha() * 0.4)
                        border.color: BatteryService.isCharging ? Theme.primary : (BatteryService.isLowBattery ? Theme.error : Theme.outlineMedium)
                        border.width: BatteryService.isCharging || BatteryService.isLowBattery ? 2 : 1
                        visible: BatteryService.batteryAvailable

                        Row {
                            anchors.left: parent.left
                            anchors.leftMargin: Theme.spacingL
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: Theme.spacingL

                            DankIcon {
                                name: Theme.getBatteryIcon(BatteryService.batteryLevel, BatteryService.isCharging, BatteryService.batteryAvailable)
                                size: Theme.iconSizeLarge
                                color: {
                                    if (BatteryService.isLowBattery && !BatteryService.isCharging)
                                        return Theme.error;

                                    if (BatteryService.isCharging)
                                        return Theme.primary;

                                    return Theme.surfaceText;
                                }
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Column {
                                spacing: 2
                                anchors.verticalCenter: parent.verticalCenter

                                Row {
                                    spacing: Theme.spacingM

                                    StyledText {
                                        text: BatteryService.batteryLevel + "%"
                                        font.pixelSize: Theme.fontSizeLarge
                                        color: {
                                            if (BatteryService.isLowBattery && !BatteryService.isCharging)
                                                return Theme.error;

                                            if (BatteryService.isCharging)
                                                return Theme.primary;

                                            return Theme.surfaceText;
                                        }
                                        font.weight: Font.Bold
                                    }

                                    StyledText {
                                        text: BatteryService.batteryStatus
                                        font.pixelSize: Theme.fontSizeMedium
                                        color: {
                                            if (BatteryService.isLowBattery && !BatteryService.isCharging)
                                                return Theme.error;

                                            if (BatteryService.isCharging)
                                                return Theme.primary;

                                            return Theme.surfaceText;
                                        }
                                        font.weight: Font.Medium
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                }

                                StyledText {
                                    text: {
                                        let time = BatteryService.formatTimeRemaining();
                                        if (time !== "Unknown")
                                            return BatteryService.isCharging ? "Time until full: " + time : "Time remaining: " + time;

                                        return "";
                                    }
                                    font.pixelSize: Theme.fontSizeSmall
                                    color: Theme.surfaceTextMedium
                                    visible: text.length > 0
                                }

                            }

                        }

                    }

                    // No battery info card
                    Rectangle {
                        width: parent.width
                        height: 80
                        radius: Theme.cornerRadiusLarge
                        color: Qt.rgba(Theme.surfaceVariant.r, Theme.surfaceVariant.g, Theme.surfaceVariant.b, Theme.getContentBackgroundAlpha() * 0.4)
                        border.color: Theme.outlineMedium
                        border.width: 1
                        visible: !BatteryService.batteryAvailable

                        Row {
                            anchors.centerIn: parent
                            spacing: Theme.spacingL

                            DankIcon {
                                name: Theme.getBatteryIcon(0, false, false)
                                size: 36
                                color: Theme.surfaceText
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Column {
                                spacing: Theme.spacingS
                                anchors.verticalCenter: parent.verticalCenter

                                StyledText {
                                    text: "No Battery Detected"
                                    font.pixelSize: Theme.fontSizeLarge
                                    color: Theme.surfaceText
                                    font.weight: Font.Medium
                                }

                                StyledText {
                                    text: "Power profile management is available"
                                    font.pixelSize: Theme.fontSizeMedium
                                    color: Theme.surfaceTextMedium
                                }

                            }

                        }

                    }

                    // Battery details
                    Column {
                        width: parent.width
                        spacing: Theme.spacingM
                        visible: BatteryService.batteryAvailable

                        StyledText {
                            text: "Battery Details"
                            font.pixelSize: Theme.fontSizeLarge
                            color: Theme.surfaceText
                            font.weight: Font.Medium
                        }

                        Row {
                            width: parent.width
                            spacing: Theme.spacingXL

                            // Health
                            Column {
                                spacing: 2
                                width: (parent.width - Theme.spacingXL) / 2

                                StyledText {
                                    text: "Health"
                                    font.pixelSize: Theme.fontSizeSmall
                                    color: Theme.surfaceTextMedium
                                    font.weight: Font.Medium
                                }

                                StyledText {
                                    text: BatteryService.batteryHealth
                                    font.pixelSize: Theme.fontSizeMedium
                                    color: {
                                        if (BatteryService.batteryHealth === "N/A")
                                            return Theme.surfaceText;

                                        var healthNum = parseInt(BatteryService.batteryHealth);
                                        return healthNum < 80 ? Theme.error : Theme.surfaceText;
                                    }
                                }

                            }

                            // Capacity
                            Column {
                                spacing: 2
                                width: (parent.width - Theme.spacingXL) / 2

                                StyledText {
                                    text: "Capacity"
                                    font.pixelSize: Theme.fontSizeSmall
                                    color: Theme.surfaceTextMedium
                                    font.weight: Font.Medium
                                }

                                StyledText {
                                    text: BatteryService.batteryCapacity > 0 ? BatteryService.batteryCapacity.toFixed(1) + " Wh" : "Unknown"
                                    font.pixelSize: Theme.fontSizeMedium
                                    color: Theme.surfaceText
                                }

                            }

                        }

                    }

                    // Power profiles
                    Column {
                        width: parent.width
                        spacing: Theme.spacingM
                        visible: true

                        StyledText {
                            text: "Power Profile"
                            font.pixelSize: Theme.fontSizeLarge
                            color: Theme.surfaceText
                            font.weight: Font.Medium
                        }

                        Column {
                            width: parent.width
                            spacing: Theme.spacingS

                            Repeater {
                                model: (typeof PowerProfiles !== "undefined") ? [PowerProfile.PowerSaver, PowerProfile.Balanced].concat(PowerProfiles.hasPerformanceProfile ? [PowerProfile.Performance] : []) : [PowerProfile.PowerSaver, PowerProfile.Balanced, PowerProfile.Performance]

                                Rectangle {
                                    width: parent.width
                                    height: 50
                                    radius: Theme.cornerRadiusLarge
                                    color: profileArea.containsMouse ? Theme.primaryHoverLight : (root.isActiveProfile(modelData) ? Theme.primaryPressed : Theme.surfaceLight)
                                    border.color: root.isActiveProfile(modelData) ? Theme.primary : Theme.outlineLight
                                    border.width: root.isActiveProfile(modelData) ? 2 : 1

                                    Row {
                                        anchors.left: parent.left
                                        anchors.leftMargin: Theme.spacingL
                                        anchors.verticalCenter: parent.verticalCenter
                                        spacing: Theme.spacingM

                                        DankIcon {
                                            name: Theme.getPowerProfileIcon(modelData)
                                            size: Theme.iconSize
                                            color: root.isActiveProfile(modelData) ? Theme.primary : Theme.surfaceText
                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                        Column {
                                            spacing: 2
                                            anchors.verticalCenter: parent.verticalCenter

                                            StyledText {
                                                text: Theme.getPowerProfileLabel(modelData)
                                                font.pixelSize: Theme.fontSizeMedium
                                                color: root.isActiveProfile(modelData) ? Theme.primary : Theme.surfaceText
                                                font.weight: root.isActiveProfile(modelData) ? Font.Medium : Font.Normal
                                            }

                                            StyledText {
                                                text: Theme.getPowerProfileDescription(modelData)
                                                font.pixelSize: Theme.fontSizeSmall
                                                color: Theme.surfaceTextMedium
                                            }

                                        }

                                    }

                                    MouseArea {
                                        id: profileArea

                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            root.setProfile(modelData);
                                        }
                                    }

                                }

                            }

                        }

                    }

                    // Degradation reason warning
                    Rectangle {
                        width: parent.width
                        height: 60
                        radius: Theme.cornerRadiusLarge
                        color: Theme.errorHover
                        border.color: Theme.primarySelected
                        border.width: 1
                        visible: (typeof PowerProfiles !== "undefined") && PowerProfiles.degradationReason !== PerformanceDegradationReason.None

                        Row {
                            anchors.left: parent.left
                            anchors.leftMargin: Theme.spacingL
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: Theme.spacingM

                            DankIcon {
                                name: "warning"
                                size: Theme.iconSize
                                color: Theme.error
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Column {
                                spacing: 2
                                anchors.verticalCenter: parent.verticalCenter

                                StyledText {
                                    text: "Power Profile Degradation"
                                    font.pixelSize: Theme.fontSizeMedium
                                    color: Theme.error
                                    font.weight: Font.Medium
                                }

                                StyledText {
                                    text: (typeof PowerProfiles !== "undefined") ? PerformanceDegradationReason.toString(PowerProfiles.degradationReason) : ""
                                    font.pixelSize: Theme.fontSizeSmall
                                    color: Qt.rgba(Theme.error.r, Theme.error.g, Theme.error.b, 0.8)
                                }

                            }

                        }

                    }

                }

            }

        }

    }

}
