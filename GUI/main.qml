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
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 12
        
        Label {
            text:"Ask me something:"
            color: "#c3c2b7"
            font.family: "Inter"
            font.pointSize: 40
            Layout.alignment: Qt.AlignHCenter
        }
        
        TextField {
            id: inputField
            placeholderText: "Type your question here..."
            Layout.preferredWidth: 400
        }
        
        Button {
            text: "Send"
            Layout.alignment: Qt.AlignHCenter
            
            onClicked: {
                console.log("User input:", inputField.text)
            }
        }
    }
}