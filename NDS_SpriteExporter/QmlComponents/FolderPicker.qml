import QtQuick
import QtQuick.Dialogs

ScalableButton {
    id: root

    property alias folderPath: folderDialog.selectedFolder

    text: qsTr("Select folder")
    onClicked: folderDialog.open()

    FolderDialog {
        id: folderDialog
        title: "Please choose a folder"
    }
}
