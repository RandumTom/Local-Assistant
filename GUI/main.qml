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
                        stackView.push(chatsPage)
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
                
                ComboBox {
                    id: voiceCombo
                    model: ["Bella", "Jasper", "Luna", "Bruno", "Rosie", "Hugo", "Kiki", "Leo"]
                    currentIndex: model.indexOf(window.backend.getAssistantVoice())
                    font.family: "JetBrains Mono"
                    font.pointSize: 16
                    Layout.preferredWidth: 400

                    onActivated: {
                        window.backend.saveAssistantVoice(voiceCombo.currentText)
                    }
                }

                Label {
                    text: "Name"
                    color: "#c3c2b7"
                    font.family: "JetBrains Mono"
                    font.pointSize: 16
                }

                TextField {
                    id: nameField
                    text: window.backend.getName()
                    placeholderText: "Enter your name..."
                    font.family: "JetBrains Mono"
                    font.pointSize: 16
                    color: "#c3c2b7"
                    Layout.preferredWidth: 400

                    background: Rectangle {
                        color: "#2c2c2a"
                        radius: 10
                    }

                    onAccepted: window.backend.saveName(nameField.text)
                }

                Label {
                    text: "Update Command"
                    color: "#c3c2b7"
                    font.family: "JetBrains Mono"
                    font.pointSize: 16
                }

                TextField {
                    id: updateCommandField
                    text: window.backend.getUpdateCommand()
                    placeholderText: "e.g. sudo dnf upgrade -y"
                    font.family: "JetBrains Mono"
                    font.pointSize: 16
                    color: "#c3c2b7"
                    Layout.preferredWidth: 400

                    background: Rectangle {
                        color: "#2c2c2a"
                        radius: 10
                    }

                    onAccepted: window.backend.saveUpdateCommand(updateCommandField.text)
                }

                Label {
                    text: "Hotkey"
                    color: "#c3c2b7"
                    font.family: "JetBrains Mono"
                    font.pointSize: 16
                }

                Rectangle {
                    id: hotkeyCapture
                    Layout.preferredWidth: 400
                    Layout.preferredHeight: 40
                    color: hotkeyCapture.activeFocus ? "#3c3c3a" : "#2c2c2a"
                    radius: 10
                    property string hotkey: window.backend.getHotkey()

                    focus: false
                    activeFocusOnTab: true

                    Text {
                        anchors.centerIn: parent
                        text: hotkeyCapture.activeFocus ? "Press new hotkey..." : (hotkeyCapture.hotkey || "Click to set hotkey")
                        color: "#c3c2b7"
                        font.family: "JetBrains Mono"
                        font.pointSize: 16
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: hotkeyCapture.forceActiveFocus()
                    }

                    Keys.onPressed: function(event) {
                        console.log("Key pressed - key:", event.key, "hex:", "0x" + event.key.toString(16), "text:", JSON.stringify(event.text), "modifiers:", event.modifiers, "scanCode:", event.nativeScanCode)
                        var parts = []
                        if (event.modifiers & Qt.ControlModifier) parts.push("Ctrl")
                        if (event.modifiers & Qt.AltModifier) parts.push("Alt")
                        if (event.modifiers & Qt.ShiftModifier) parts.push("Shift")
                        if (event.modifiers & Qt.MetaModifier) parts.push("Super")

                        var keyName = ""
                        if (event.key !== Qt.Key_Control &&
                            event.key !== Qt.Key_Alt &&
                            event.key !== Qt.Key_Shift &&
                            event.key !== Qt.Key_Meta) {

                            var keyMap = {}
                            keyMap[Qt.Key_Space] = "Space"
                            keyMap[Qt.Key_Return] = "Enter"
                            keyMap[Qt.Key_Escape] = "Escape"
                            keyMap[Qt.Key_Tab] = "Tab"
                            keyMap[Qt.Key_Backspace] = "Backspace"
                            keyMap[Qt.Key_Delete] = "Delete"
                            keyMap[Qt.Key_Up] = "Up"
                            keyMap[Qt.Key_Down] = "Down"
                            keyMap[Qt.Key_Left] = "Left"
                            keyMap[Qt.Key_Right] = "Right"
                            keyMap[0x010000A6] = "Assistant"

                            if (event.key in keyMap) {
                                keyName = keyMap[event.key]
                            } else if (event.key >= Qt.Key_A && event.key <= Qt.Key_Z) {
                                keyName = String.fromCharCode(event.key)
                            } else if (event.key >= Qt.Key_0 && event.key <= Qt.Key_9) {
                                keyName = String.fromCharCode(event.key)
                            } else if (event.key >= Qt.Key_F1 && event.key <= Qt.Key_F35) {
                                keyName = "F" + (event.key - Qt.Key_F1 + 1)
                            } else if (event.text !== "") {
                                keyName = event.text.toUpperCase()
                            } else {
                                keyName = "Scan_" + event.nativeScanCode
                            }

                            if (keyName !== "") {
                                parts.push(keyName)
                                hotkeyCapture.hotkey = parts.join("+")
                                window.backend.saveHotkey(hotkeyCapture.hotkey)
                                hotkeyCapture.focus = false
                            }
                        }

                        event.accepted = true
                    }
                }
                
                Label {
                    text: "Save Chats"
                    color: "#c3c2b7"
                    font.family: "JetBrains Mono"
                    font.pointSize: 16
                }
                
                Switch {
                    id: saveChatsSwitch
                    checked: window.backend.getSaveChats()
                    
                    onToggled: {
                        window.backend.setSaveChats(saveChatsSwitch.checked)
                    }
                }

                Button {
                    id: resetButton
                    text: resetButton.confirmMode ? "Are you sure?" : "Reset Config"
                    property bool confirmMode: false
                    font.family: "JetBrains Mono"
                    font.pointSize: 14

                    background: Rectangle {
                        color: resetButton.confirmMode ? "#cc3333" : "#2c2c2a"
                        radius: 10
                    }

                    contentItem: Text {
                        text: resetButton.text
                        color: "#c3c2b7"
                        font: resetButton.font
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        if (confirmMode) {
                            window.backend.resetConfig()
                            confirmMode = false
                        } else {
                            confirmMode = true
                        }
                    }
                }
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: window.backend.needsSetup() ? setupPage : homePage
    }
    
    Component {
        id: setupPage
        
        Item {
            anchors.fill: parent
            
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20
                
                Label {
                    text: "Welcome to Local Assistant by RandumTom!"
                    color: "#c3c2b7"
                    font.family: "JetBrains Mono"
                    font.pointSize: 24
                    Layout.alignment: Qt.AlignHCenter
                }
                
                Label { text: "What should I call you?"; color: "#c3c2b7"; font.family: "JetBrains Mono"; font.pointSize: 16 }
                TextField {
                    id: setupName
                    placeholderText: "Enter your name"
                    font.family: "JetBrains Mono"; font.pointSize: 16; color: "#c3c2b7"
                    Layout.preferredWidth: 400
                    background: Rectangle { color: "#2c2c2a"; radius: 10 }
                }
                
                Label { text: "Pick a voice:"; color: "#c3c2b7"; font.family: "JetBrains Mono"; font.pointSize: 16 }
                ComboBox {
                    id: setupVoice
                    model: ["Bella", "Jasper", "Luna", "Bruno", "Rosie", "Hugo", "Kiki", "Leo"]
                    font.family: "JetBrains Mono"; font.pointSize: 16;
                    Layout.preferredWidth: 400
                }
                
                Label { text: "What city are you in?"; color: "#c3c2b7"; font.family: "JetBrains Mono"; font.pointSize: 16 }
                TextField {
                    id: setupCity
                    placeholderText: "Enter your city"
                    font.family: "JetBrains Mono"; font.pointSize: 16; color: "#c3c2b7"
                    Layout.preferredWidth: 400
                    background: Rectangle { color: "#2c2c2a"; radius: 10 }
                }
                
                Button {
                    text: "Done"
                    Layout.alignment: Qt.AlignHCenter
                    font.family: "JetBrains Mono"; font.pointSize: 16
                    
                    contentItem: Text {
                        text: "Done"
                        color: "#c3c2b7"
                        font: parent.font
                        horizontalAlignment: Text.AlignHCenter
                    }
                    background: Rectangle {color: "#2c2c2a"; radius: 10 }
                    
                    onClicked: {
                        window.backend.saveName(setupName.text)
                        window.backend.saveAssistantVoice(setupVoice.currentText)
                        window.backend.saveCity(setupCity.text)
                        stackView.replace(homePage)
                    }
                }
            }
        }
    }
    
    Component {
        id: chatsPage
        
        Item {
            anchors.fill: parent
            
            Item {
                id: chatsBackButton
                width: 75
                height: 75
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
                z: 1
                
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
                id: chatsTitle
                text: "Chats"
                color: "#c3c2b7"
                font.family: "JetBrains Mono"
                font.pointSize: 32
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 40
            }
            
            TextField {
                id: chatsSearchField
                placeholderText: "Search your chats..."
                font.family: "JetBrains Mono"
                font.pointSize: 14
                color: "#c3c2b7"
                anchors.top: chatsTitle.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.6
                
                background: Rectangle {
                    color: "#2c2c2a"
                    radius: 20
                }
            }
        
        ListView {
            id: chatsList
            anchors.top: chatsSearchField.bottom
            anchors.topMargin: 20
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.6
            clip: true
            spacing: 2
            
            Component.onCompleted: {
                var chats = JSON.parse(window.backend.getChats())
                for (var i = 0; i < chats.length; i++) {
                    chatsListModel.append({
                        chatId: chats[i].id,
                        title: chats[i].messages[0].text,
                        timestamp: chats[i].timestamp
                    })
                }
            }
            
            model: ListModel {
                id: chatsListModel
            }
            
            delegate: Rectangle {
                width: chatsList.width
                height: 70
                color: chatMouseArea.containsMouse ? "#3c3c3a" : "transparent"
                radius: 10
                
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    anchors.rightMargin: 20
                    spacing: 4
                    
                    Item { Layout.fillHeight: true }
                    
                    Label {
                        text: model.title
                        color: "#c3c2b7"
                        font.family: "JetBrains Mono"
                        font.pointSize: 14
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                    
                    Label {
                        text: {
                            var then = new Date(model.timestamp)
                            var now = new Date()
                            var diffMs = now - then
                            var diffMins = Math.floor(diffMs / 60000)
                            var diffHours = Math.floor(diffMs / 3600000)
                            var diffDays = Math.floor(diffMs / 86400000)
                            
                            if (diffMins < 1) return "Just now"
                            if (diffMins < 60) return "Last message " + diffMins + " minutes ago"
                            if (diffHours < 24) return "Last message " + diffHours + " hours ago"
                            return "Last message " + diffDays + " days ago"
                        }
                        color: "#7a7a6e"
                        font.family: "JetBrains Mono"
                        font.pointSize: 11
                    }
                    
                    Item { Layout.fillHeight: true }
                }
                
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: 20
                    anchors.rightMargin: 20
                    height: 1
                    color: "#3c3c3a"
                }
                
                MouseArea {
                    id: chatMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        console.log("Chat clicked: ", model.chatId)
                    }
                }
            }
        }
        }
    }
}