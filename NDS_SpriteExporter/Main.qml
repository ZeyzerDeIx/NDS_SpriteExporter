import QtQuick
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15

Window {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Button {
        id: changeTitleBtn
        x: 129
        y: 168
        text: qsTr("Change Title")
        onClicked: backend.changeTitle(mainWindow, newTitleTxtField.text)
    }

    TextField {
        id: newTitleTxtField
        x: 313
        y: 198
        placeholderText: qsTr("NewTitle")
        onTextChanged: backend.changeTitle(mainWindow, newTitleTxtField.text)
    }
}
