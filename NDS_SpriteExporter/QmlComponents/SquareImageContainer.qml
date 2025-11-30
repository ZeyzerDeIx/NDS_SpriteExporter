import QtQuick

Rectangle {
    id: root
    color: "transparent"
    radius: 20
    border.color: selected ? "#3399ff" : "#004d99"
    border.width: 3

    // Property alias to allow outside access to the image source
    property alias source: internalImage.source
    property bool selected: false
    property point parentProportions: Qt.point(0.9, 0.9)


    signal imageLoaded()

    width: parent.width * parentProportions.x
    height: parent.height * parentProportions.y
    anchors.centerIn: parent

    Image {
        id: internalImage
        anchors.fill: parent
        anchors.margins: 4
        fillMode: Image.PreserveAspectFit
        onSourceChanged: imageLoaded()
    }
}
