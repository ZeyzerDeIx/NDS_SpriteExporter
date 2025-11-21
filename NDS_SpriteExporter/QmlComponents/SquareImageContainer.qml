import QtQuick

Rectangle {
    id: root
    color: "transparent"
    radius: 20
    border.color: internalImage.source.toString() !== "" ? "#3399ff" : "#004d99"
    border.width: 3

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
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        fillMode: Image.PreserveAspectFit
    }
}
