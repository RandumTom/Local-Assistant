import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    color: "#1f1f1e"
    title: "Local Assistant"
    id: window
    required property var backend
    visibility: Window.Maximized

    FontLoader {
        id: interFont
        source: "fonts/JetBrainsMono-Regular.ttf"
    }

    function microphoneImage(color) {
        return 'data:image/svg+xml,
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <path fill="' + color + '" d="M12 14c1.66 0 3-1.34 3-3V5c0-1.66-1.34-3-3-3S9 3.34 9 5v6c0 1.66 1.34 3 3 3z"/>
                <path fill="' + color + '" d="M17 11c0 2.76-2.24 5-5 5s-5-2.24-5-5H5c0 3.53 2.61 6.43 6 6.92V21h2v-3.08c3.39-.49 6-3.39 6-6.92h-2z"/>
            </svg>'
    }

    function settinsGear(color) {
        return 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="' + color + '" d="M19.14 12.94a7.07 7.07 0 0 0 .06-.94c0-.32-.02-.64-.07-.94l2.03-1.58a.49.49 0 0 0 .12-.61l-1.92-3.32a.49.49 0 0 0-.59-.22l-2.39.96a7.04 7.04 0 0 0-1.62-.94l-.36-2.54a.48.48 0 0 0-.48-.41h-3.84a.48.48 0 0 0-.48.41l-.36 2.54c-.59.24-1.13.57-1.62.94l-2.39-.96a.48.48 0 0 0-.59.22L2.74 8.87a.48.48 0 0 0 .12.61l2.03 1.58c-.05.3-.07.62-.07.94s.02.64.07.94l-2.03 1.58a.49.49 0 0 0-.12.61l1.92 3.32c.12.22.37.29.59.22l2.39-.96c.5.37 1.03.7 1.62.94l.36 2.54c.05.24.26.41.48.41h3.84c.24 0 .44-.17.48-.41l.36-2.54c.59-.24 1.13-.56 1.62-.94l2.39.96c.22.08.47 0 .59-.22l1.92-3.32a.49.49 0 0 0-.12-.61l-2.03-1.58zM12 15.6A3.6 3.6 0 1 1 12 8.4a3.6 3.6 0 0 1 0 7.2z"/></svg>'
    }

    function chatsIcon(color) {
        return 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="' + color + '" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 12A8 8 0 0 0 12 4 8 8 0 0 0 4 12a8 8 0 0 0 8 8c1.33 0 2.58-.33 3.68-.9l3.82.9-.9-3.82A7.95 7.95 0 0 0 20 12z"/></svg>'
    }

    Component {
        id: homePage

        Item {
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 70
                spacing: 12

                Item { Layout.fillHeight: true }

                Label {
                    text: window.backend.greeting + "," + window.backend.username
                    color: "#c3c2b7"
                    font.family: "JetBrains Mono"
                    font.pointSize: 40
                    Layout.alignment: Qt.AlignHCenter
                }

                Item { // Microphone Icon
                    width: 150
                    height: 150
                    Layout.alignment: Qt.AlignHCenter

                    Rectangle {
                        anchors.fill: parent
                        color: "#c0c0c0"
                        radius: width / 2
                    }

                    Image {
                        anchors.centerIn: parent
                        source: microphoneImage("#1f1f1e")
                        sourceSize.width: 80
                        sourceSize.height: 80
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            window.backend.micPressed()
                        }
                    }
                }

                Item { Layout.fillHeight: true }

                TextField {
                    id: inputField
                    placeholderText: "Type your question here..."
                    Layout.preferredWidth: 600
                    Layout.preferredHeight: 40
                    Layout.alignment: Qt.AlignHCenter
                    font.family: "JetBrains Mono"
                    font.pointSize: 16
                    color: "#c3c2b7"

                    background: Rectangle {
                        color: "#2c2c2a"
                        radius: 20
                    }

                    onAccepted: {
                        window.backend.sendMessage(inputField.text)
                        inputField.text = ""
                    }
                }
            }

            Item { // Settings Icon
                width: 75
                height: 75
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.margins: 20

                Rectangle {
                    anchors.fill: parent
                    color: "#c0c0c0"
                    radius: width / 2
                }

                Image {
                    anchors.centerIn: parent
                    source: settinsGear("#1f1f1e")
                    sourceSize.width: 40
                    sourceSize.height: 40
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        stackView.push(settingsPage)
                    }
                }
            }

            Item { // Chats Icon
                width: 75
                height: 75
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20

                Rectangle {
                    anchors.fill: parent
                    color: "#c0c0c0"
                    radius: width / 2
                }

                Image {
                    anchors.centerIn: parent
                    source: chatsIcon("#1f1f1e")
                    sourceSize.width: 40
                    sourceSize.height: 40
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        window.backend.chatsPressed()
                    }
                }
            }
        }
    }

    Component {
        id: settingsPage

        Item {
            anchors.fill: parent

            Item {
                width: 75
                height: 75
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20

                Rectangle {
                    anchors.fill: parent
                    color: "#c0c0c0"
                    radius: width / 2
                }

                Text {
                    anchors.centerIn: parent
                    text: "←"
                    font.pointSize: 24
                    color: "#1f1f1e"
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: stackView.pop()
                }
            }

            Label {
                text: "Settings Page"
                color: "#c3c2b7"
                font.family: "JetBrains Mono"
                font.pointSize: 32
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 40
            }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                Label {
                    text: "City"
                    color: "#c3c2b7"
                    font.family: "JetBrains Mono"
                    font.pointSize: 16
                }

                TextField {
                    id: cityField
                    text: window.backend.getCity()
                    font.family: "JetBrains Mono"
                    font.pointSize: 16
                    color: "#c3c2b7"
                    Layout.preferredWidth: 400

                    background: Rectangle {
                        color: "#2c2c2a"
                        radius: 10
                    }

                    onAccepted: window.backend.saveCity(cityField.text)
                }

                Label {
                    text: "Voice"
                    color: "#c3c2b7"
                    font.family: "JetBrains Mono"
                    font.pointSize: 16
                }
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: homePage
    }
}
