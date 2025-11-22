import QtQuick
import QtQuick.Controls

NeutralContainer {
    id: root

    // --- PROPERTIES ---
    property alias labelText: label.text
    property alias inputText: field.text
    property point parentProportions: Qt.point(0.5, 0.15)

    anchors.centerIn: parent
    width: parent.width * parentProportions.x
    height: parent.height * parentProportions.y

    // CHANGED: Switched to Column Layout (Vertical)
    CustomColLay {
        anchors.fill: parent

        // --- PROPORTIONAL SPACING ---
        spacing: root.height * 0.05

        // --- TOP SECTION : LABEL ---
        NeutralContainer {
            Label {
                id: label
                anchors.fill: parent
                anchors.leftMargin: width * 0.02
                text: qsTr("Label")

                // Align bottom-left is standard for labels above inputs
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignLeft

                // Adjust font size calculation for the new container height
                font.pixelSize: height * 0.8
                fontSizeMode: Text.Fit
                color: field.focus || field.hovered ? "white" : "#808080"
            }
        }

        // --- BOTTOM SECTION : INPUT ---
        NeutralContainer {
            weigh: 2

            ScalableTextField {
                id: field
                parentProportions: Qt.point(1, 1)
            }
        }
    }
}
