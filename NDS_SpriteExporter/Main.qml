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
                        FolderPicker{
                            id: assetsFolderPicker
                            parentProportions: Qt.point(0.75,0.65)
                            text: qsTr("Select assets folder")
                        }
                    }
                    NeutralContainer {
                        FolderPicker{
                            id: nitrofsFolderPicker
                            parentProportions: Qt.point(0.75,0.65)
                            text: qsTr("Select nitrofs folder")
                        }
                    }
                    NeutralContainer {
                        weigh: 7
                        CustomColLay {
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
                                    onImageLoaded: {
                                        spriteName.inputText = backend.extractFileName(imageContainer.source);
                                        rightSideHalf.visible = true;
                                    }
                                }
                            }
                        }
                    }
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
                                    imageContainer.source,
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
