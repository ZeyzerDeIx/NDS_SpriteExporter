import QtQuick
import QtQuick.Controls

Slider {
    id: root

    // --- PROPERTIES ---
    // Text metrics for value display logic
    property TextMetrics tm: TextMetrics {
        font.pixelSize: 20
        text: Math.round(root.value).toString()
    }

    property color grooveColor: "#272541"
    property color filledGrooveColor: "#004d99"
    property color hoverGrooveColor: "#004d99"
    property color hoverFilledGrooveColor: "#3399ff"
    property color handleColor: "#272541"
    property color handleBorderColor: "#004d99"
    property color hoverHandleColor: "#004d99"
    property color hoverHandleBorderColor: "#3399ff"
    property color textColor: "white"

    // Default proportions: wider than tall for a slider
    property point parentProportions: Qt.point(0.5, 0.05)

    // Range setup (example)
    from: 1
    to: 10
    value: 1

    // --- CENTERED IN PARENT ---
    anchors.centerIn: parent

    // --- ENSURE SCALABILITY ---
    width: parent.width * parentProportions.x
    // Height determines the handle size primarily
    height: parent.height * parentProportions.y

    // --- ENSURE FONT RESIZE ---
    onWidthChanged: Qt.callLater(resize)
    onHeightChanged: Qt.callLater(resize)

    function resize() {
        if (width === 0 || height === 0) return;
        // Logic adapted: font size depends on the handle height (root.height)
        // to ensure the value fits inside the knob.
        let targetHeight = root.height;
        let fy = targetHeight / tm.height * tm.font.pixelSize * 0.5;
        font.pixelSize = Math.max(10, fy); // Minimum limit to stay readable
    }

    // --- BACKGROUND (GROOVE) ---
    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: root.availableWidth
        height: root.height * 0.5 // Groove is thinner than the handle
        radius: height / 3
        color: root.hovered || root.focus ? root.hoverGrooveColor : root.grooveColor

        // Optional: Filled part of the slider
        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            color: root.hovered || root.focus ? root.hoverFilledGrooveColor : root.filledGrooveColor
            radius: height / 3
        }
    }

    // --- HANDLE (KNOB) ---
    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        width: root.height
        height: root.height
        radius: height / 5
        color: root.pressed ? Qt.lighter(root.hoverHandleColor, 1.2) : root.hovered || root.focus ? root.hoverHandleColor : root.handleColor
        border.color: root.hovered || root.focus ? root.hoverHandleBorderColor : root.handleBorderColor
        border.width: 2

        // Value Text inside the handle
        Text {
            anchors.centerIn: parent
            text: Math.round(root.value)
            color: root.textColor
            font: root.font
        }
    }
}
