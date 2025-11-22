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
    title: qsTr("Zeyzer's NDS Sprite Exporter")

    // --- UI STRUCTURE ---
    CustomDropArea {
        onDropped: (drop) => {
           if (drop.hasUrls && backend.checkFileValidity(drop.urls[0]))
           imageContainer.source = drop.urls[0];
       }

        CustomRowLay {
            // --- LEFT SIDE ---
            NeutralContainer {

                CustomColLay {
                    NeutralContainer{
                        LabeledScalableTextField{
                            labelText: qsTr("Sprite name")
                            parentProportions: Qt.point(0.95,0.15)
                        }
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
                        FilePickerButton {
                            linkedImageContainer: imageContainer
                            parentProportions: Qt.point(0.75,0.65)
                            text: qsTr("Import spritesheet")
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
