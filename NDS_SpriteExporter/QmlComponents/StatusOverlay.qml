import QtQuick

Rectangle {
    id: root
    visible: false
    anchors.fill: parent
    z: 10 // Always on top

    // Custom properties to configure the overlay
    property alias message: label.text
    property alias textColor: label.color

    Text {
        id: label
        anchors.centerIn: parent
        font.pixelSize: 44
        color: "#ffffff"
    }
}
