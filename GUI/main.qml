import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Local Assistant"
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 12
        
        Label {
            text:"Ask me something:"
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