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
                weigh: 2
                CustomColLay {
                    Spacer{}
                    NeutralContainer {
                        weigh: 14
                        ImagePicker {
                            id: imagePicker
                            onImageAccepted: {
                                spriteName.inputText = backend.extractFileName(imagePicker.source);
                                rightSideHalf.visible = true;
                            }
                        }
                    }
                    Spacer{}
                    NeutralContainer {
                        weigh: 2
                        FolderPicker{
                            id: assetsFolderPicker
                            parentProportions: Qt.point(0.9,0.65)
                            text: qsTr("Select assets folder")
                        }
                    }
                    NeutralContainer {
                        weigh: 2
                        FolderPicker{
                            id: nitrofsFolderPicker
                            parentProportions: Qt.point(0.9,0.65)
                            text: qsTr("Select nitrofs folder")
                        }
                    }
                    Spacer{}
                }
            }

            // --- RIGHT SIDE ---
            NeutralContainer {
                id: rightSideHalf
                visible: false
                weigh: 3
                CustomColLay {
                    Spacer{}
                    NeutralContainer {
                        LabeledScalableTextField {
                            id: spriteName
                            labelText: qsTr("Sprite name")
                            parentProportions: Qt.point(0.95,0.8)
                        }
                    }
                    NeutralContainer {
                        LabeledScalableSlider{
                            labelText: qsTr("Number of frames (W)")
                            parentProportions:  Qt.point(0.95,0.8)
                        }
                    }
                    NeutralContainer {
                        LabeledScalableSlider{
                            labelText: qsTr("Number of states (H)")
                            parentProportions:  Qt.point(0.95,0.8)
                        }
                    }
                    Spacer{}
                    NeutralContainer {
                        ScalableButton {
                            text: qsTr("Export")
                            parentProportions:  Qt.point(0.95,0.6)
                            onClicked: {
                                backend.exportSprite(
                                    imagePicker.source,
                                    spriteName.inputText,
                                    assetsFolderPicker.folderPath,
                                    nitrofsFolderPicker.folderPath
                                );
                            }
                        }
                    }
                    Spacer{}
                }
            }
        }
    }
}
