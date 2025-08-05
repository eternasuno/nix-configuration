import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import qs.Common
import qs.Widgets

ScrollView {
    id: launcherTab

    contentHeight: column.implicitHeight + Theme.spacingXL
    clip: true

    Column {
        id: column

        width: parent.width
        spacing: Theme.spacingXL
        topPadding: Theme.spacingL
        bottomPadding: Theme.spacingXL

        StyledRect {
            width: parent.width
            height: appLauncherSection.implicitHeight + Theme.spacingL * 2
            radius: Theme.cornerRadiusLarge
            color: Qt.rgba(Theme.surfaceVariant.r, Theme.surfaceVariant.g, Theme.surfaceVariant.b, 0.3)
            border.color: Qt.rgba(Theme.outline.r, Theme.outline.g, Theme.outline.b, 0.2)
            border.width: 1

            Column {
                id: appLauncherSection

                anchors.fill: parent
                anchors.margins: Theme.spacingL
                spacing: Theme.spacingM

                DankToggle {
                    width: parent.width
                    text: "Use OS Logo"
                    description: "Display operating system logo instead of apps icon"
                    checked: Prefs.useOSLogo
                    onToggled: (checked) => {
                        return Prefs.setUseOSLogo(checked);
                    }
                }

                Row {
                    width: parent.width - Theme.spacingL
                    spacing: Theme.spacingL
                    visible: Prefs.useOSLogo
                    opacity: visible ? 1 : 0
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.spacingL

                    Column {
                        width: 120
                        spacing: Theme.spacingS

                        StyledText {
                            text: "Color Override"
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.surfaceText
                            font.weight: Font.Medium
                        }

                        DankTextField {
                            width: 100
                            height: 28
                            placeholderText: "#ffffff"
                            text: Prefs.osLogoColorOverride
                            maximumLength: 7
                            font.pixelSize: Theme.fontSizeSmall
                            topPadding: Theme.spacingXS
                            bottomPadding: Theme.spacingXS
                            onEditingFinished: {
                                var color = text.trim();
                                if (color === "" || /^#[0-9A-Fa-f]{6}$/.test(color))
                                    Prefs.setOSLogoColorOverride(color);
                                else
                                    text = Prefs.osLogoColorOverride;
                            }
                        }

                    }

                    Column {
                        width: 120
                        spacing: Theme.spacingS

                        StyledText {
                            text: "Brightness"
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.surfaceText
                            font.weight: Font.Medium
                        }

                        DankSlider {
                            width: 100
                            height: 20
                            minimum: 0
                            maximum: 100
                            value: Math.round(Prefs.osLogoBrightness * 100)
                            unit: "%"
                            showValue: true
                            onSliderValueChanged: (newValue) => {
                                Prefs.setOSLogoBrightness(newValue / 100);
                            }
                        }

                    }

                    Column {
                        width: 120
                        spacing: Theme.spacingS

                        StyledText {
                            text: "Contrast"
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.surfaceText
                            font.weight: Font.Medium
                        }

                        DankSlider {
                            width: 100
                            height: 20
                            minimum: 0
                            maximum: 200
                            value: Math.round(Prefs.osLogoContrast * 100)
                            unit: "%"
                            showValue: true
                            onSliderValueChanged: (newValue) => {
                                Prefs.setOSLogoContrast(newValue / 100);
                            }
                        }

                    }

                    Behavior on opacity {
                        NumberAnimation {
                            duration: Theme.mediumDuration
                            easing.type: Theme.emphasizedEasing
                        }

                    }

                }

            }

        }

        StyledRect {
            width: parent.width
            height: dockSection.implicitHeight + Theme.spacingL * 2
            radius: Theme.cornerRadiusLarge
            color: Qt.rgba(Theme.surfaceVariant.r, Theme.surfaceVariant.g, Theme.surfaceVariant.b, 0.3)
            border.color: Qt.rgba(Theme.outline.r, Theme.outline.g, Theme.outline.b, 0.2)
            border.width: 1

            Column {
                id: dockSection

                anchors.fill: parent
                anchors.margins: Theme.spacingL
                spacing: Theme.spacingM

                Row {
                    width: parent.width
                    spacing: Theme.spacingM

                    DankIcon {
                        name: "dock_to_bottom"
                        size: Theme.iconSize
                        color: Theme.primary
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    StyledText {
                        text: "Dock"
                        font.pixelSize: Theme.fontSizeLarge
                        font.weight: Font.Medium
                        color: Theme.surfaceText
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                DankToggle {
                    width: parent.width
                    text: "Show Dock"
                    description: "Display a dock at the bottom of the screen with pinned and running applications"
                    checked: Prefs.showDock
                    onToggled: (checked) => {
                        Prefs.setShowDock(checked)
                    }
                }

                DankToggle {
                    width: parent.width
                    text: "Auto-hide Dock"
                    description: "Hide the dock when not in use and reveal it when hovering near the bottom of the screen"
                    checked: Prefs.dockAutoHide
                    visible: Prefs.showDock
                    opacity: visible ? 1 : 0
                    onToggled: (checked) => {
                        Prefs.setDockAutoHide(checked)
                    }

                    Behavior on opacity {
                        NumberAnimation {
                            duration: Theme.mediumDuration
                            easing.type: Theme.emphasizedEasing
                        }
                    }
                }

                Column {
                    width: parent.width
                    spacing: Theme.spacingS
                    visible: Prefs.showDock
                    opacity: visible ? 1 : 0

                    StyledText {
                        text: "Dock Transparency"
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.surfaceText
                        font.weight: Font.Medium
                    }

                    DankSlider {
                        width: parent.width
                        height: 24
                        value: Math.round(Prefs.dockTransparency * 100)
                        minimum: 0
                        maximum: 100
                        unit: ""
                        showValue: true
                        onSliderValueChanged: (newValue) => {
                            Prefs.setDockTransparency(newValue / 100);
                        }
                    }

                    Behavior on opacity {
                        NumberAnimation {
                            duration: Theme.mediumDuration
                            easing.type: Theme.emphasizedEasing
                        }
                    }
                }

            }
        }

        StyledRect {
            width: parent.width
            height: recentlyUsedSection.implicitHeight + Theme.spacingL * 2
            radius: Theme.cornerRadiusLarge
            color: Qt.rgba(Theme.surfaceVariant.r, Theme.surfaceVariant.g, Theme.surfaceVariant.b, 0.3)
            border.color: Qt.rgba(Theme.outline.r, Theme.outline.g, Theme.outline.b, 0.2)
            border.width: 1

            Column {
                id: recentlyUsedSection

                property var rankedAppsModel: {
                    var apps = [];
                    for (var appId in Prefs.appUsageRanking) {
                        var appData = Prefs.appUsageRanking[appId];
                        apps.push({
                            "id": appId,
                            "name": appData.name,
                            "exec": appData.exec,
                            "icon": appData.icon,
                            "comment": appData.comment,
                            "usageCount": appData.usageCount,
                            "lastUsed": appData.lastUsed
                        });
                    }
                    apps.sort(function(a, b) {
                        if (a.usageCount !== b.usageCount)
                            return b.usageCount - a.usageCount;

                        return a.name.localeCompare(b.name);
                    });
                    return apps.slice(0, 20);
                }

                anchors.fill: parent
                anchors.margins: Theme.spacingL
                spacing: Theme.spacingM

                Row {
                    width: parent.width
                    spacing: Theme.spacingM

                    DankIcon {
                        name: "history"
                        size: Theme.iconSize
                        color: Theme.primary
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    StyledText {
                        text: "Recently Used Apps"
                        font.pixelSize: Theme.fontSizeLarge
                        font.weight: Font.Medium
                        color: Theme.surfaceText
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Item {
                        width: parent.width - parent.children[0].width - parent.children[1].width - clearAllButton.width - Theme.spacingM * 3
                        height: 1
                    }

                    DankActionButton {
                        id: clearAllButton

                        iconName: "delete_sweep"
                        iconSize: Theme.iconSize - 2
                        iconColor: Theme.error
                        hoverColor: Qt.rgba(Theme.error.r, Theme.error.g, Theme.error.b, 0.12)
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            Prefs.appUsageRanking = {
                            };
                            Prefs.saveSettings();
                        }
                    }

                }

                StyledText {
                    width: parent.width
                    text: "Apps are ordered by usage frequency, then last used, then alphabetically."
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.surfaceVariantText
                    wrapMode: Text.WordWrap
                }

                Column {
                    id: rankedAppsList

                    width: parent.width
                    spacing: Theme.spacingS

                    Repeater {
                        model: recentlyUsedSection.rankedAppsModel

                        delegate: Rectangle {
                            width: rankedAppsList.width
                            height: 48
                            radius: Theme.cornerRadius
                            color: Qt.rgba(Theme.surfaceContainer.r, Theme.surfaceContainer.g, Theme.surfaceContainer.b, 0.3)
                            border.color: Qt.rgba(Theme.outline.r, Theme.outline.g, Theme.outline.b, 0.1)
                            border.width: 1

                            Row {
                                anchors.left: parent.left
                                anchors.leftMargin: Theme.spacingM
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: Theme.spacingM

                                StyledText {
                                    text: (index + 1).toString()
                                    font.pixelSize: Theme.fontSizeSmall
                                    font.weight: Font.Medium
                                    color: Theme.primary
                                    width: 20
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                Image {
                                    width: 24
                                    height: 24
                                    source: modelData.icon ? "image://icon/" + modelData.icon : "image://icon/application-x-executable"
                                    sourceSize.width: 24
                                    sourceSize.height: 24
                                    fillMode: Image.PreserveAspectFit
                                    anchors.verticalCenter: parent.verticalCenter
                                    onStatusChanged: {
                                        if (status === Image.Error)
                                            source = "image://icon/application-x-executable";

                                    }
                                }

                                Column {
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 2

                                    StyledText {
                                        text: modelData.name || "Unknown App"
                                        font.pixelSize: Theme.fontSizeMedium
                                        font.weight: Font.Medium
                                        color: Theme.surfaceText
                                    }

                                    StyledText {
                                        text: {
                                            if (!modelData.lastUsed)
                                                return "Never used";

                                            var date = new Date(modelData.lastUsed);
                                            var now = new Date();
                                            var diffMs = now - date;
                                            var diffMins = Math.floor(diffMs / (1000 * 60));
                                            var diffHours = Math.floor(diffMs / (1000 * 60 * 60));
                                            var diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
                                            if (diffMins < 1)
                                                return "Last launched just now";

                                            if (diffMins < 60)
                                                return "Last launched " + diffMins + " minute" + (diffMins === 1 ? "" : "s") + " ago";

                                            if (diffHours < 24)
                                                return "Last launched " + diffHours + " hour" + (diffHours === 1 ? "" : "s") + " ago";

                                            if (diffDays < 7)
                                                return "Last launched " + diffDays + " day" + (diffDays === 1 ? "" : "s") + " ago";

                                            return "Last launched " + date.toLocaleDateString();
                                        }
                                        font.pixelSize: Theme.fontSizeSmall
                                        color: Theme.surfaceVariantText
                                    }

                                }

                            }

                            DankActionButton {
                                anchors.right: parent.right
                                anchors.rightMargin: Theme.spacingM
                                anchors.verticalCenter: parent.verticalCenter
                                circular: true
                                iconName: "close"
                                iconSize: 16
                                iconColor: Theme.error
                                hoverColor: Qt.rgba(Theme.error.r, Theme.error.g, Theme.error.b, 0.12)
                                onClicked: {
                                    var currentRanking = Object.assign({
                                    }, Prefs.appUsageRanking);
                                    delete currentRanking[modelData.id];
                                    Prefs.appUsageRanking = currentRanking;
                                    Prefs.saveSettings();
                                }
                            }

                        }

                    }

                    StyledText {
                        width: parent.width
                        text: recentlyUsedSection.rankedAppsModel.length === 0 ? "No apps have been launched yet." : ""
                        font.pixelSize: Theme.fontSizeMedium
                        color: Theme.surfaceVariantText
                        horizontalAlignment: Text.AlignHCenter
                        visible: recentlyUsedSection.rankedAppsModel.length === 0
                    }

                }

            }

        }

    }

}
