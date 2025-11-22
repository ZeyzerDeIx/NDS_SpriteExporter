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
        onDropped: (drop) => {
           if (drop.hasUrls && backend.checkFileValidity(drop.urls[0]))
           imageContainer.source = drop.urls[0];
       }

        CustomRowLay {
            // --- LEFT SIDE ---
            NeutralContainer {

                ColumnLayout {
                    anchors.fill: parent
                    NeutralContainer{

                    }
                    NeutralContainer{

                    }
                }
            }

            // --- RIGHT SIDE ---
            NeutralContainer {
                CustomColLay {
                    Spacer{}
                    NeutralContainer {
                        ScalableButton {
                            parentProportions: Qt.point(0.75,0.65)
                            text: qsTr("Import spritesheet")
                            onClicked: fileDialog.open()
                        }
                    }

                    NeutralContainer {
                        weigh: 6
                        SquareImageContainer {
                            id: imageContainer
                        }
                    }
                }
            }


        }
    }
}
