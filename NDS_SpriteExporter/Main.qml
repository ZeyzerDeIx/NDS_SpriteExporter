import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs

import "QmlComponents"

Window {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    color: "#1b1b1b"
    visibility: Window.AutomaticVisibility
    title: qsTr("Hello World")

    // --- LOGIC & DIALOGS ---

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        nameFilters: ["Image files (*.png *.bmp)"]
        onAccepted: {
            if(backend.checkFileValidity(fileDialog.selectedFile))
                imageContainer.source = fileDialog.selectedFile;
        }
    }

    // --- UI STRUCTURE ---

    CustomDropArea {
        onDroppedExternal: (drop) => {
            if (drop.hasUrls && backend.checkFileValidity(drop.urls[0]))
                imageContainer.source = drop.urls[0];
        }

        RowLayout {
            anchors.fill: parent
            spacing: 0

            // --- LEFT SIDE ---
            NeutralContainer {

                // English comment: Using our custom component
                ScalableButton {
                    anchors.centerIn: parent
                    width: parent.width / 2
                    height: parent.height / 5
                    text: qsTr("Import spritesheet")
                    onClicked: fileDialog.open()
                }
            }

            // --- RIGHT SIDE ---
            NeutralContainer {

                // English comment: Using our custom component
                SquareImageContainer {
                    id: imageContainer
                    // Logic is handled inside the component file
                }
            }
        }
    }
}
