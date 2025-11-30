import QtQuick

CustomColLay {

    property alias source: imageContainer.source

    signal imageAccepted()

    NeutralContainer {
        FilePickerButton {
            linkedImageContainer: imageContainer
            parentProportions: Qt.point(0.9,0.65)
            text: qsTr("Import spritesheet")
        }
    }
    NeutralContainer {
        weigh: imageContainer.visible ? 6 : 0
        SquareImageContainer {
            id: imageContainer
            parentProportions: Qt.point(0.9,1)
            visible: false
            onImageLoaded: imageAccepted()
        }
    }
}
