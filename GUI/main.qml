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
    visibility: Window.Maximized
    
    FontLoader {
        id: interFont
        source: "fonts/JetBrainsMono-Regular.ttf"
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 30
        spacing: 12

        Item {
            Layout.fillHeight: true
        }

        Label {
            text:"greetingBasedOnTimeOfDay + userName"
            color: "#c3c2b7"
            font.family: "JetBrains Mono"
            font.pointSize: 40
            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            Layout.fillHeight: true
        }

        TextField {
            id: inputField
            placeholderText: "Type your question here..."
            Layout.preferredWidth: 600
            Layout.preferredHeight: 40
            Layout.alignment: Qt.AlignHCenter
            font.family: "JetBrains Mono"
            font.pointSize: 16
        }
    }
}