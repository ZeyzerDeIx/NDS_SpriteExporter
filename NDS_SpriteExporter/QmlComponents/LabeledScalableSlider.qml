import QtQuick
import QtQuick.Controls

NeutralContainer {
    id: root

    // --- PROPERTIES ---
    property alias labelText: label.text
    // Alias slider properties to root
    property alias value: slider.value
    property alias from: slider.from
    property alias to: slider.to

    property point parentProportions: Qt.point(0.5, 0.15)

    anchors.centerIn: parent
    width: parent.width * parentProportions.x
    height: parent.height * parentProportions.y

    // --- VERTICAL LAYOUT ---
    CustomColLay {
        anchors.fill: parent

        // --- PROPORTIONAL SPACING ---
        spacing: root.height * 0.05

        // --- TOP SECTION: LABEL ---
        NeutralContainer {
            // Default weight: 1 (implicit)

            Label {
                id: label
                anchors.fill: parent
                anchors.leftMargin: width * 0.02
                text: qsTr("Label")

                // Align bottom-left
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignLeft

                // Font sizing
                font.pixelSize: height * 0.8
                fontSizeMode: Text.Fit

                // Highlight label when slider is active
                color: slider.pressed || slider.hovered || slider.focus ? "white" : "#808080"
            }
        }

        // --- BOTTOM SECTION: SLIDER ---
        NeutralContainer {
            weigh: 2

            ScalableSlider {
                id: slider
                // Fill the container completely since scaling is handled by the root container
                parentProportions: Qt.point(1, 1)
            }
        }
    }
}
