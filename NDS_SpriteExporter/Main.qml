import QtQuick
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs

Window {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        nameFilters: ["Image files (*.png *.bmp)"]

        // Log the selected file path
        onAccepted: {
            spriteSheetImage.source = fileDialog.selectedFile;
        }
    }


    DropArea {
        id: dropArea
        x: 0
        y: 280
        anchors.fill: parent
        onEntered: (drop) => {
            if(!drop.hasUrls || !backend.checkFileValidity(drop.urls[0]))
                invalideFileTypeRect.visible = true;
            else valideFileTypeRect.visible = true;
        }
        onExited: {
            invalideFileTypeRect.visible = false;
            valideFileTypeRect.visible = false;
        }

        onDropped: (drop) => {
            invalideFileTypeRect.visible = false;
            valideFileTypeRect.visible = false;
            if (drop.hasUrls && backend.checkFileValidity(drop.urls[0]))
                spriteSheetImage.source = drop.urls[0];
        }

        Button {
            id: importSpriteSheetButton
            text: qsTr("Import a spritesheet")
            anchors.fill: parent
            anchors.leftMargin: 44
            anchors.rightMargin: 344
            anchors.topMargin: 145
            anchors.bottomMargin: 299
            highlighted: false
            flat: false
            onClicked: fileDialog.open()
        }

        Rectangle {
            id: spriteSheetImageRect
            color: "#ffffff"
            radius: 20
            border.width: 4
            anchors.fill: parent
            anchors.leftMargin: 328
            anchors.rightMargin: 42
            anchors.topMargin: 29
            anchors.bottomMargin: 183

            Image {
                id: spriteSheetImage
                anchors.fill: parent
                anchors.leftMargin: 7
                anchors.rightMargin: 7
                anchors.topMargin: 7
                anchors.bottomMargin: 7
                source: "qrc:/qtquickplugin/images/template_image.png"
                fillMode: Image.PreserveAspectFit
            }
        }
    }



    Rectangle {
        id: invalideFileTypeRect
        visible: false
        color: "#ff0000"
        anchors.fill: parent

        Text {
            id: invalideFileTypeText
            color: "#ffffff"
            text: qsTr("Invalide file type!")
            anchors.fill: parent
            font.pixelSize: 44
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle {
        id: valideFileTypeRect
        visible: false
        color: "#00ff31"
        anchors.fill: parent
        Text {
            id: valideFileTypeText
            color: "#ffffff"
            text: qsTr("Valide file type")
            anchors.fill: parent
            font.pixelSize: 44
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
