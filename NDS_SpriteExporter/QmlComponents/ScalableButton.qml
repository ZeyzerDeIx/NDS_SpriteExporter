import QtQuick
import QtQuick.Controls

ToolButton {
    id: root

    // --- PROPERTIES ---
    property TextMetrics tm: TextMetrics {
        font.pixelSize: 20
        text: root.text
    }
    property color bgColor: "#272541"
    property color hoverBgColor: "#004d99"
    property color borderColor: "#004d99"
    property color hoverBorderColor: "#3399ff"
    property color textColor: "white"
    property point parentProportions: Qt.point(0.5, 0.15)


    // --- CENTERED IN PARENT ---
    anchors.centerIn: parent

    // --- ENSURE SCALABILITY ---
    width: parent.width * parentProportions.x
    height: parent.height * parentProportions.y

    // --- ENSURE FONT RESIZE ---
    onWidthChanged: Qt.callLater(resize)
    onHeightChanged: Qt.callLater(resize)

    function resize() {
        if (width === 0 || height === 0) return;
        let fx = width / tm.width * tm.font.pixelSize * 0.8;
        let fy = height / tm.height * tm.font.pixelSize * 0.8;
        font.pixelSize = Math.min(fx, fy);
    }

    // --- BACKGROUND COLOR CHANGE ---
    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        anchors.fill: parent
        radius: 8
        border.width: 2

        border.color: root.hovered || root.focus ?
                          root.hoverBorderColor :
                          root.borderColor
        color: root.pressed ?
                Qt.lighter(root.hoverBgColor, 1.2) :
                root.hovered || root.focus ?
                   root.hoverBgColor :
                   root.bgColor
    }

    // --- FONT COLOR CHANGE ---
    contentItem: Text {
        text: root.text
        font: root.font

        color: textColor

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
