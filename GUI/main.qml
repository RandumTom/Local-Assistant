import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

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
    
    function microphoneImage(color) {
        return 'data:image/svg+xml,
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <path fill="' + color + '" d="M12 14c1.66 0 3-1.34 3-3V5c0-1.66-1.34-3-3-3S9 3.34 9 5v6c0 1.66 1.34 3 3 3z"/>
                <path fill="' + color + '" d="M17 11c0 2.76-2.24 5-5 5s-5-2.24-5-5H5c0 3.53 2.61 6.43 6 6.92V21h2v-3.08c3.39-.49 6-3.39 6-6.92h-2z"/>
            </svg>'
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