import QtQuick

Rectangle {
    id: root
    color: "#ffffff"
    radius: 20
    border.width: 4

    // Property alias to allow outside access to the image source
    property alias source: internalImage.source

    // Logic: Calculate size based on the smallest dimension of the parent
    property real sideLength: Math.min(parent.width, parent.height) - 50

    width: sideLength
    height: sideLength
    anchors.centerIn: parent

    Image {
        id: internalImage
        anchors.fill: parent
        anchors.margins: 10
        source: "qrc:/qtquickplugin/images/template_image.png" // Default
        fillMode: Image.PreserveAspectFit
    }
}
