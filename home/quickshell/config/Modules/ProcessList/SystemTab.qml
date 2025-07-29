import QtQuick
import QtQuick.Controls
import qs.Common
import qs.Services
import qs.Widgets

ScrollView {
    anchors.fill: parent
    clip: true
    ScrollBar.vertical.policy: ScrollBar.AsNeeded
    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

    Component.onCompleted: {
        SysMonitorService.addRef();
    }

    Component.onDestruction: {
        SysMonitorService.removeRef();
    }

    Column {
        width: parent.width
        spacing: Theme.spacingM

        Rectangle {
            width: parent.width
            height: systemInfoColumn.implicitHeight + 2 * Theme.spacingL
            radius: Theme.cornerRadiusLarge
            color: Qt.rgba(Theme.surfaceContainer.r, Theme.surfaceContainer.g, Theme.surfaceContainer.b, 0.6)
            border.width: 0

            Column {
                id: systemInfoColumn
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: Theme.spacingL
                spacing: Theme.spacingL

                Row {
                    width: parent.width
                    spacing: Theme.spacingL

                    SystemLogo {
                        width: 80
                        height: 80
                    }

                    Column {
                        width: parent.width - 80 - Theme.spacingL
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: Theme.spacingS

                        StyledText {
                            text: SysMonitorService.hostname
                            font.pixelSize: Theme.fontSizeXLarge
                            font.family: Prefs.monoFontFamily
                            font.weight: Font.Light
                            color: Theme.surfaceText
                            verticalAlignment: Text.AlignVCenter
                        }

                        StyledText {
                            text: SysMonitorService.distribution + " • " + SysMonitorService.architecture + " • " + SysMonitorService.kernelVersion
                            font.pixelSize: Theme.fontSizeMedium
                            font.family: Prefs.monoFontFamily
                            color: Qt.rgba(Theme.surfaceText.r, Theme.surfaceText.g, Theme.surfaceText.b, 0.7)
                            verticalAlignment: Text.AlignVCenter
                        }

                        StyledText {
                            text: "Up " + UserInfoService.uptime + " • Boot: " + SysMonitorService.bootTime
                            font.pixelSize: Theme.fontSizeSmall
                            font.family: Prefs.monoFontFamily
                            color: Qt.rgba(Theme.surfaceText.r, Theme.surfaceText.g, Theme.surfaceText.b, 0.6)
                            verticalAlignment: Text.AlignVCenter
                        }

                        StyledText {
                            text: "Load: " + SysMonitorService.loadAverage + " • " + SysMonitorService.processCount + " processes, " + SysMonitorService.threadCount + " threads"
                            font.pixelSize: Theme.fontSizeSmall
                            font.family: Prefs.monoFontFamily
                            color: Qt.rgba(Theme.surfaceText.r, Theme.surfaceText.g, Theme.surfaceText.b, 0.6)
                            verticalAlignment: Text.AlignVCenter
                        }

                    }

                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: Qt.rgba(Theme.outline.r, Theme.outline.g, Theme.outline.b, 0.2)
                }

                Row {
                    width: parent.width
                    spacing: Theme.spacingXL

                    Rectangle {
                        width: (parent.width - Theme.spacingXL) / 2
                        height: Math.max(hardwareColumn.implicitHeight, memoryColumn.implicitHeight) + Theme.spacingM
                        radius: Theme.cornerRadius
                        color: Qt.rgba(Theme.surfaceContainerHigh.r, Theme.surfaceContainerHigh.g, Theme.surfaceContainerHigh.b, 0.4)
                        border.width: 1
                        border.color: Qt.rgba(Theme.outline.r, Theme.outline.g, Theme.outline.b, 0.1)

                        Column {
                            id: hardwareColumn
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.margins: Theme.spacingM
                            spacing: Theme.spacingXS

                            Row {
                                width: parent.width
                                spacing: Theme.spacingS

                                DankIcon {
                                    name: "memory"
                                    size: Theme.iconSizeSmall
                                    color: Theme.primary
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                StyledText {
                                    text: "Hardware"
                                    font.pixelSize: Theme.fontSizeSmall
                                    font.family: Prefs.monoFontFamily
                                    font.weight: Font.Bold
                                    color: Theme.primary
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            StyledText {
                                text: SysMonitorService.cpuModel
                                font.pixelSize: Theme.fontSizeSmall
                                font.family: Prefs.monoFontFamily
                                font.weight: Font.Medium
                                color: Theme.surfaceText
                                width: parent.width
                                elide: Text.ElideRight
                                wrapMode: Text.NoWrap
                                maximumLineCount: 1
                                verticalAlignment: Text.AlignVCenter
                            }

                            StyledText {
                                text: SysMonitorService.motherboard
                                font.pixelSize: Theme.fontSizeSmall
                                font.family: Prefs.monoFontFamily
                                color: Qt.rgba(Theme.surfaceText.r, Theme.surfaceText.g, Theme.surfaceText.b, 0.8)
                                width: parent.width
                                elide: Text.ElideRight
                                wrapMode: Text.NoWrap
                                maximumLineCount: 1
                                verticalAlignment: Text.AlignVCenter
                            }

                            StyledText {
                                text: "BIOS " + SysMonitorService.biosVersion
                                font.pixelSize: Theme.fontSizeSmall
                                font.family: Prefs.monoFontFamily
                                color: Qt.rgba(Theme.surfaceText.r, Theme.surfaceText.g, Theme.surfaceText.b, 0.7)
                                width: parent.width
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }

                    Rectangle {
                        width: (parent.width - Theme.spacingXL) / 2
                        height: Math.max(hardwareColumn.implicitHeight, memoryColumn.implicitHeight) + Theme.spacingM
                        radius: Theme.cornerRadius
                        color: Qt.rgba(Theme.surfaceContainerHigh.r, Theme.surfaceContainerHigh.g, Theme.surfaceContainerHigh.b, 0.4)
                        border.width: 1
                        border.color: Qt.rgba(Theme.outline.r, Theme.outline.g, Theme.outline.b, 0.1)

                        Column {
                            id: memoryColumn
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.margins: Theme.spacingM
                            spacing: Theme.spacingXS

                            Row {
                                width: parent.width
                                spacing: Theme.spacingS

                                DankIcon {
                                    name: "developer_board"
                                    size: Theme.iconSizeSmall
                                    color: Theme.secondary
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                StyledText {
                                    text: "Memory"
                                    font.pixelSize: Theme.fontSizeSmall
                                    font.family: Prefs.monoFontFamily
                                    font.weight: Font.Bold
                                    color: Theme.secondary
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            StyledText {
                                text: SysMonitorService.formatSystemMemory(SysMonitorService.totalMemoryKB) + " Total"
                                font.pixelSize: Theme.fontSizeSmall
                                font.family: Prefs.monoFontFamily
                                font.weight: Font.Medium
                                color: Theme.surfaceText
                                width: parent.width
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            StyledText {
                                text: SysMonitorService.formatSystemMemory(SysMonitorService.usedMemoryKB) + " Used • " + SysMonitorService.formatSystemMemory(SysMonitorService.totalMemoryKB - SysMonitorService.usedMemoryKB) + " Available"
                                font.pixelSize: Theme.fontSizeSmall
                                font.family: Prefs.monoFontFamily
                                color: Qt.rgba(Theme.surfaceText.r, Theme.surfaceText.g, Theme.surfaceText.b, 0.7)
                                width: parent.width
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            Item {
                                width: parent.width
                                height: Theme.fontSizeSmall + Theme.spacingXS
                            }
                        }
                    }

                }

            }

        }


        Rectangle {
            width: parent.width
            height: storageColumn.implicitHeight + 2 * Theme.spacingL
            radius: Theme.cornerRadiusLarge
            color: Qt.rgba(Theme.surfaceContainer.r, Theme.surfaceContainer.g, Theme.surfaceContainer.b, 0.6)
            border.width: 0

            Column {
                id: storageColumn
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: Theme.spacingL
                spacing: Theme.spacingS

                Row {
                    width: parent.width
                    spacing: Theme.spacingS

                    DankIcon {
                        name: "storage"
                        size: Theme.iconSize
                        color: Theme.surfaceText
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    StyledText {
                        text: "Storage & Disks"
                        font.pixelSize: Theme.fontSizeLarge
                        font.family: Prefs.monoFontFamily
                        font.weight: Font.Bold
                        color: Theme.surfaceText
                        anchors.verticalCenter: parent.verticalCenter
                    }

                }


                Column {
                    width: parent.width
                    spacing: 2

                        Row {
                            width: parent.width
                            height: 24
                            spacing: Theme.spacingS

                            StyledText {
                                text: "Device"
                                font.pixelSize: Theme.fontSizeSmall
                                font.family: Prefs.monoFontFamily
                                font.weight: Font.Bold
                                color: Theme.surfaceText
                                width: parent.width * 0.25
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            StyledText {
                                text: "Mount"
                                font.pixelSize: Theme.fontSizeSmall
                                font.family: Prefs.monoFontFamily
                                font.weight: Font.Bold
                                color: Theme.surfaceText
                                width: parent.width * 0.2
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            StyledText {
                                text: "Size"
                                font.pixelSize: Theme.fontSizeSmall
                                font.family: Prefs.monoFontFamily
                                font.weight: Font.Bold
                                color: Theme.surfaceText
                                width: parent.width * 0.15
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            StyledText {
                                text: "Used"
                                font.pixelSize: Theme.fontSizeSmall
                                font.family: Prefs.monoFontFamily
                                font.weight: Font.Bold
                                color: Theme.surfaceText
                                width: parent.width * 0.15
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            StyledText {
                                text: "Available"
                                font.pixelSize: Theme.fontSizeSmall
                                font.family: Prefs.monoFontFamily
                                font.weight: Font.Bold
                                color: Theme.surfaceText
                                width: parent.width * 0.15
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                            StyledText {
                                text: "Use%"
                                font.pixelSize: Theme.fontSizeSmall
                                font.family: Prefs.monoFontFamily
                                font.weight: Font.Bold
                                color: Theme.surfaceText
                                width: parent.width * 0.1
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter
                            }

                        }

                        Repeater {
                            id: diskMountRepeater

                            model: SysMonitorService.diskMounts

                            Rectangle {
                                width: parent.width
                                height: 24
                                radius: Theme.cornerRadiusSmall
                                color: diskMouseArea.containsMouse ? Qt.rgba(Theme.surfaceText.r, Theme.surfaceText.g, Theme.surfaceText.b, 0.04) : "transparent"

                                MouseArea {
                                    id: diskMouseArea

                                    anchors.fill: parent
                                    hoverEnabled: true
                                }

                                Row {
                                    anchors.fill: parent
                                    spacing: Theme.spacingS

                                    StyledText {
                                        text: modelData.device
                                        font.pixelSize: Theme.fontSizeSmall
                                        font.family: Prefs.monoFontFamily
                                        color: Theme.surfaceText
                                        width: parent.width * 0.25
                                        elide: Text.ElideRight
                                        anchors.verticalCenter: parent.verticalCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    StyledText {
                                        text: modelData.mount
                                        font.pixelSize: Theme.fontSizeSmall
                                        font.family: Prefs.monoFontFamily
                                        color: Theme.surfaceText
                                        width: parent.width * 0.2
                                        elide: Text.ElideRight
                                        anchors.verticalCenter: parent.verticalCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    StyledText {
                                        text: modelData.size
                                        font.pixelSize: Theme.fontSizeSmall
                                        font.family: Prefs.monoFontFamily
                                        color: Theme.surfaceText
                                        width: parent.width * 0.15
                                        elide: Text.ElideRight
                                        anchors.verticalCenter: parent.verticalCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    StyledText {
                                        text: modelData.used
                                        font.pixelSize: Theme.fontSizeSmall
                                        font.family: Prefs.monoFontFamily
                                        color: Theme.surfaceText
                                        width: parent.width * 0.15
                                        elide: Text.ElideRight
                                        anchors.verticalCenter: parent.verticalCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    StyledText {
                                        text: modelData.avail
                                        font.pixelSize: Theme.fontSizeSmall
                                        font.family: Prefs.monoFontFamily
                                        color: Theme.surfaceText
                                        width: parent.width * 0.15
                                        elide: Text.ElideRight
                                        anchors.verticalCenter: parent.verticalCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    StyledText {
                                        text: modelData.percent
                                        font.pixelSize: Theme.fontSizeSmall
                                        font.family: Prefs.monoFontFamily
                                        color: {
                                            const percent = parseInt(modelData.percent);
                                            if (percent > 90)
                                                return Theme.error;

                                            if (percent > 75)
                                                return Theme.warning;

                                            return Theme.surfaceText;
                                        }
                                        width: parent.width * 0.1
                                        elide: Text.ElideRight
                                        anchors.verticalCenter: parent.verticalCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                }

                            }

                        }

                    }

            }

        }

    }

}
