import QtQuick
import QtQuick.Dialogs

ScalableButton {
    id: root
    property SquareImageContainer linkedImageContainer

    text: qsTr("Import image")
    onClicked: fileDialog.open()
    onFocusChanged: root.linkedImageContainer.selected = focus || hovered
    onHoveredChanged: root.linkedImageContainer.selected = focus || hovered

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        nameFilters: ["Image files (*.png *.bmp)"]
        onAccepted: {
            if(backend.checkFileValidity(fileDialog.selectedFile))
            {
                root.linkedImageContainer.source = fileDialog.selectedFile;
                root.linkedImageContainer.visible = true;
            }
        }
    }
}
