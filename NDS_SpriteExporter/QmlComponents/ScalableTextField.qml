import QtQuick
import QtQuick.Controls

TextField {
    id: root

    // --- PROPERTIES ---
    property color bgColor: "#333333"
    property color borderColor: "#004d99"
    property color activeBorderColor: "#3399ff"
    property color textColor: "white"
    property point parentProportions: Qt.point(0.5, 0.15)

    // --- CENTERED IN PARENT ---
    anchors.centerIn: parent

    // --- ENSURE SCALABILITY ---
    width: parent.width * parentProportions.x
    height: parent.height * parentProportions.y

    // --- ENSURE FONT RESIZE ---
    onHeightChanged: Qt.callLater(resize)

    // Initial resize
    Component.onCompleted: resize()

    function resize() {
        if (height === 0) return;
        // Calculate font size based primarily on height (approx 60% of container)
        // We avoid width-based scaling here to prevent text from shrinking while typing
        let fy = height * 0.6;
        font.pixelSize = fy;
    }

    // --- TEXT STYLING ---
    color: textColor
    horizontalAlignment: Text.AlignLeft
    verticalAlignment: Text.AlignVCenter

    // --- BACKGROUND COLOR CHANGE ---
    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        anchors.fill: parent
        radius: 8
        border.width: 2

        border.color: root.activeFocus || root.hovered ? root.activeBorderColor : root.borderColor
        color: root.bgColor
    }
}
